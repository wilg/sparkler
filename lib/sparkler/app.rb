module Sparkler

	require "grit"
	require "yaml"
	require "xcodeproj"
	require "CFPropertyList"
	require 'fileutils'
	require 'pathname'

	class InvalidAppError < UserFacingError ; end

	class App

		attr_accessor :repo_path

		def initialize(path)
			self.repo_path = path
		end

		def repo
			@repo ||= begin
				Grit::Repo.new(self.repo_path)
			rescue Grit::InvalidGitRepositoryError => e
				raise InvalidAppError, "This directory is not a Git repository."
			end
		end

		def head
			self.repo.commits.first
		end

		def release_for_head
			Release.new(self, head.id)
		end

		# TODO: Find derived data automagically.
		# http://pilky.me/view/25

		# def xcodeproj
		# 	Xcodeproj::Project.new(Dir.glob(File.join(self.repo_path,'*.xcodeproj')).first).build_configurations.map{|x| x.build_settings.to_s}
		# end

		def settings
			@settings ||= begin
				YAML.load_file File.join(self.repo_path, "sparkler.yml")
			rescue
				raise InvalidAppError, "Couldn't load sparkler.yml file. Try running 'sparkler init'"
			end
		end

		def build
			self.settings["built_app_path"]
		end

		def name
			self.settings["app_name"]
		end

	end

end