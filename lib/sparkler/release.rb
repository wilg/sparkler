module Sparkler

	class Release

		attr_accessor :app, :hash

		def initialize(app, hash)
			self.app = app
			self.hash = hash
		end

		def publish!

			puts "Publishing #{SETTINGS["app_name"]} release #{current_version_number}."
			puts "Compressing app..."
			AutoAppcast.zip_folder(SETTINGS["built_app_path"], temporary_zipped_version_path)
			puts "Uploading application..."
			upload_public_file_to_s3(temporary_zipped_version_path, zipped_filename)

			puts "Writing appcast..."
			write_file temporary_appcast_path, appcast_data
			upload_public_file_to_s3(temporary_appcast_path, "appcast.xml")

			puts "Writing release notes..."
			write_file temporary_release_notes_path, release_notes_data
			upload_public_file_to_s3(temporary_release_notes_path, "release_notes.html")

			puts "Writing head id..."
			write_file temporary_head_path, current_head_id
			upload_public_file_to_s3(temporary_head_path, "head_id.txt")

			puts "Writing releases log..."
			write_file temporary_release_list_path, releases_list_data.to_yaml
			upload_public_file_to_s3(temporary_release_list_path, "releases.yml")

			puts "Released!"

		end

		def build_info
			@build_info ||= begin
				plist = CFPropertyList::List.new(:file => "#{app.build}/Contents/Info.plist")
				CFPropertyList.native_types(plist.value)
			end
		end

		def built_version
			build_info["CFBundleVersion"]
		end

		def zip_name
			"#{app.name.gsub(" ", "_")}_#{built_version}.zip".downcase
		end

		def zipball
			zipball_path = File.join Dir.tmpdir, zip_name
			`cd #{app.build};cd ..;zip -r "#{app.build}.zip" "#{Pathname.new(app.build).basename}"`
			FileUtils.mv("#{app.build}.zip", "#{zipball_path}")
			zipball_path
		end

	end

end