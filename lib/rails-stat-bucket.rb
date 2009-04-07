require 'yaml'
module RailsStatBucket
  def self.generate(input_directory, output_filename, verbose = false)
    git = `which git`.strip
    rake = `which rake`.strip
    if system("cd #{input_directory} && #{git} status | grep 'nothing to commit' > /dev/null")
      puts 'Nothing to commit, proceeding with stats check.'

      previous_date = nil
      @collector = []

      %x{cd #{input_directory} && #{git} log --date=short | grep 'Date:' -B 2}.split('--').each do |log_entry|
        if matched_data = log_entry.match(/^Date: +(\d{4}-\d{2}-\d{2})/)
          current_date = matched_data[1]
          if verbose || previous_date != current_date
            if match_commit_entry = log_entry.match(/^commit (\w+)/)
              commit_id = match_commit_entry[1]
              stats = %x(cd #{input_directory} && #{git} checkout #{commit_id} && #{rake} stats)
              if match_stats = stats.match(/^ +Code LOC: ?(\d+) +Test LOC: ?(\d+)/)
                @collector << {:date => current_date, :lines_of_code => match_stats[1].to_i, :lines_of_test_code => match_stats[2].to_i }
              end
            end
          end
          previous_date = current_date
        end
      end
      @collector.reverse!
      File.open(output_filename, 'w+') do |file|
        YAML.dump(@collector, file)
      end
    else
      puts 'Unable to proceed with stat check. Directory directory.'
      exit!(-1)
    end
  end

  def self.load(params)

  end

  class Entry

  end
end
