bactrace_shortener
------------------

This shortens the backtraces of exceptions to make debugging more friendly. Exceptions which are thrown in
Ruby apps which use rbenv and gems like Sinatra can be taller than one terminal screen, and each line can be
long. See below for an example of the pain. Shortening these backtraces makes debugging more friendly.

I find myself using this in many of my projects, so it's now packaged as a gem.

Usage
-----

    $ gem install backtrace_shortener

    (or you can just take backtrace_shortener.rb and copy it to your project. It's short.)

    In your code

    require "backtrace_shortener"

Features
--------

With it installed, an unwieldy exception backtrace which previously looked like this:

    RuntimeError: It's no good, I can't maneuver!
    /Users/philc/api_server/server.rb:86:in `block in <class:ServerRoot>'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:1212:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:1212:in `block in compile!'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:785:in `[]'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:785:in `block (3 levels) in route!'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:801:in `route_eval'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:785:in `block (2 levels) in route!'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:822:in `block in process_route'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:820:in `catch'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:820:in `process_route'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:784:in `block in route!'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:783:in `each'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:783:in `route!'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:886:in `dispatch!'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:719:in `block in call!'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:871:in `block in invoke'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:871:in `catch'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:871:in `invoke'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:719:in `call!'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:705:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-protection-1.2.0/lib/rack/protection/xss_header.rb:22:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-protection-1.2.0/lib/rack/protection/path_traversal.rb:16:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-protection-1.2.0/lib/rack/protection/json_csrf.rb:17:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-protection-1.2.0/lib/rack/protection/base.rb:47:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-protection-1.2.0/lib/rack/protection/xss_header.rb:22:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-1.4.1/lib/rack/nulllogger.rb:9:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-1.4.1/lib/rack/head.rb:9:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:1334:in `block in call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:1416:in `synchronize'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/sinatra-1.3.2/lib/sinatra/base.rb:1334:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-1.4.1/lib/rack/lint.rb:48:in `_call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-1.4.1/lib/rack/lint.rb:36:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-1.4.1/lib/rack/showexceptions.rb:24:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-1.4.1/lib/rack/commonlogger.rb:20:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-1.4.1/lib/rack/chunked.rb:43:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-1.4.1/lib/rack/content_length.rb:14:in `call'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/thin-1.3.1/lib/thin/connection.rb:80:in `block in pre_process'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/thin-1.3.1/lib/thin/connection.rb:78:in `catch'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/thin-1.3.1/lib/thin/connection.rb:78:in `pre_process'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/thin-1.3.1/lib/thin/connection.rb:53:in `process'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/thin-1.3.1/lib/thin/connection.rb:38:in `receive_data'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/eventmachine-0.12.10/lib/eventmachine.rb:256:in `run_machine'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/eventmachine-0.12.10/lib/eventmachine.rb:256:in `run'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/thin-1.3.1/lib/thin/backends/base.rb:61:in `start'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/thin-1.3.1/lib/thin/server.rb:159:in `start'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-1.4.1/lib/rack/handler/thin.rb:13:in `run'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-1.4.1/lib/rack/server.rb:265:in `start'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-1.4.1/lib/rack/server.rb:137:in `start'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/rack-1.4.1/bin/rackup:4:in `<top (required)>'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/bin/rackup:19:in `load'
    /Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/bin/rackup:19:in `<main>'api_server


Gets shortened to this. Long method chains which are within gems get collapsed, and the RubyGems path (in my case, `/Users/philc/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1`) gets trimmed from each line.

      RuntimeError: It's no good, I can't maneuver!
      /Users/philc/html5player/api_server/app/server_root.rb:88:in `block in <class:ServerRoot>'
      <..>
      .../gems/sinatra-1.3.2/lib/sinatra/base.rb:705:in `call'
      <..>
      .../gems/rack-protection-1.2.0/lib/rack/protection/xss_header.rb:22:in `call'
      .../gems/rack-1.4.1/lib/rack/nulllogger.rb:9:in `call'
      .../gems/rack-1.4.1/lib/rack/head.rb:9:in `call'
      <..>
      .../gems/sinatra-1.3.2/lib/sinatra/base.rb:1334:in `call'
      <..>
      .../gems/rack-1.4.1/lib/rack/content_length.rb:14:in `call'
      <..>
      .../gems/thin-1.3.1/lib/thin/connection.rb:38:in `receive_data'
      .../gems/eventmachine-0.12.10/lib/eventmachine.rb:256:in `run_machine'
      .../gems/eventmachine-0.12.10/lib/eventmachine.rb:256:in `run'
      .../gems/thin-1.3.1/lib/thin/backends/base.rb:61:in `start'
      .../gems/thin-1.3.1/lib/thin/server.rb:159:in `start'
      <..>
      .../gems/rack-1.4.1/bin/rackup:4:in `<top (required)>'
      .../bin/rackup:19:in `load'
      .../bin/rackup:19:in `<main>


If you want to see even less or filter things specific to your application, add your own filters. For example,
this filter rejects any line originating from a Gem:

    BacktraceShortener.filters.unshift(Proc.new do |backtrace|
      backtrace.reject { |line| line.include?(Gem.dir) }
    end)

Another example which truncates the backtrace to include only the first 10 lines:

    BacktraceShortener.filters.unshift(Proc.new { |backtrace| backtrace[0, 10] }

If you need to access the full backtrace while debugging, you can call `my_exception.full_backtrace`.
