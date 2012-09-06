module Sparkler

  require "thor"
  require "colorize"

  class CommandLine < Thor

  	desc "release", "Publishes the current HEAD of your repository according to your settings."
  	def release
  		app = App.new File.expand_path(".")
  		release = app.release_for_head
  		puts "Releasing #{release.hash} as release #{release.built_version}...".yellow
  		puts app.release_for_head.zipball.to_s.green
  		# puts app.head
  		# puts " ----- "
  		# puts app.settings
  		# puts " ----- "
  		# puts app.plist_info.to_s
	  rescue UserFacingError => e
	  	puts "#{e}".red
  	end


    # desc "set <pixel> <r> <g> <b>", "light up a pixel. rgb values from 0.0 - 1.0"
    # method_option :remote, type: :boolean, aliases: "-r", desc: "Set the pixel over the network.", default: false
    # method_option :hostname, type: :string, aliases: "-h", desc: "Network hostname.", default: "localhost"
    # method_option :port, type: :numeric, aliases: "-h", desc: "Network port.", default: 3010
    # def set(pixel, r, g, b)
    #   c = open_connection(options)
    #   m = message_from_console_array [pixel, r, g, b]
    #   c.write_message m
    #   c.write_message Lorraine::Message.new(:refresh)
    # end
  end

end