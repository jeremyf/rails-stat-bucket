module RailsStatBucket
  def self.generate(input_directory, output_filename, verbose = false)
    git = `which git`.strip
    if system("cd #{input_directory} && #{git} status | grep 'nothing to commit' > /dev/null")
      puts 'Nothing to commit, proceeding with stats check.'
      
      previous_date = nil
      %x{cd #{input_directory} && #{git} log --date=short | grep 'Date:' -B 2}.split('--').each do |log_entry|
        if matched_data = log_entry.match(/^Date: +(\d{4}-\d{2}-\d{2})/)
          current_date = matched_data[1]
          if verbose || previous_date != current_date 
            puts current_date
          end
          previous_date = current_date
        end
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
