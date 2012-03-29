# This can patch the Exception class to prune the size of the backtraces and to make each line shorter.
# The idea is to improve the developer experience, because exceptions in apps using rbenv and gems can be
# taller than one terminal screen and each line can be long. See how painful this is with a 50 line backtrace:
#   ...
#   /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sequel-3.28.0/lib/sequel/adapters/mysql.rb:175:in `query'
#   /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sequel-3.28.0/lib/sequel/adapters/mysql.rb:175:in `block in _execute'
#   ...
#
# To apply this patch, invoke BacktraceCleanear.monkey_patch_the_exception_class!
#
# If you want to access the full backtrace while debugging, you can use my_exception.full_backtrace.
# If you want to write your own filter, append your own Proc to BacktraceShortener.filters:
#   BacktraceShortener.filters.unshift(Proc.new { |backtrace| backtrace[0, 10] }) # Shortens to 10 lines.
module BacktraceShortener
  def self.monkey_patch_the_exception_class!
    return if Exception.new.respond_to?(:backtrace_prior_to_backtrace_shortener_monkey_patch)

    Exception.class_eval do
      alias :backtrace_prior_to_backtrace_shortener_monkey_patch :backtrace
      alias :full_backtrace :backtrace_prior_to_backtrace_shortener_monkey_patch

      def backtrace
        backtrace = backtrace_prior_to_backtrace_shortener_monkey_patch
        return nil if backtrace.nil?
        BacktraceShortener.filters.inject(backtrace) { |backtrace, filter| filter.call(backtrace) }
      end
    end
  end

  # Abbreviate any long gem paths, e.g.
  #     /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sequel-3.28.0/lib
  #  => .../gems/1.9.1/gems/sequel-3.28.0/lib
  def self.abbreviate_gem_directory_name(backtrace)
    backtrace.map do |line|
      line.sub(Gem.dir, "...")
    end
  end

  # Backtraces which involve gems can include many lines from within the gem's internals. This usually
  # isn't helpful. Collapse those long sequences of lines and include just the first and last line.
  def self.collapse_gems(backtrace)
    current_gem = nil
    current_gem_line_number = nil
    i = backtrace.size - 1

    while i >= 0
      line_gem = gem_from_line(backtrace[i])
      if line_gem != current_gem || i == 0
        if current_gem && (current_gem_line_number - i) > 2
          backtrace[i..current_gem_line_number] = [backtrace[i], "<..>", backtrace[current_gem_line_number]]
        end
        current_gem = line_gem
        current_gem_line_number = i
      end
      i -= 1
    end
    backtrace
  end

  # Returns the gem in the given backtrace line, or nil if the line does not include a gem in it.
  def self.gem_from_line(backtrace_line)
    # Pull out "sequel-3.28.0" from this path: ".../lib/ruby/gems/1.9.1/gems/sequel-3.28.0/lib/..."
    (%r{/ruby/gems/[^/]+/gems/([^/]+)/}.match(backtrace_line) || [])[1]
  end

  class << self
    attr_accessor :filters
  end

  # The two default filters are 1) collapsing long runs of lines from gems and 2) abbreviating those lines.
  self.filters = [method(:collapse_gems), method(:abbreviate_gem_directory_name)]
end
