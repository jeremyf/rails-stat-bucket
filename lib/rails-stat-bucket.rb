require 'yaml'
module RailsStatBucket
  def self.generate(input_directory, output_filename, options = {})
    git = `which git`.strip
    rake = `which rake`.strip
    if system("cd #{input_directory} && #{git} status | grep 'nothing to commit' > /dev/null")
      begin
        puts 'Nothing to commit, proceeding with stats check.'

        previous_date = nil
        @collector = []

        %x{cd #{input_directory} && #{git} log --date=short | grep 'Date:' -B 2}.split('--').each do |log_entry|
          if matched_data = log_entry.match(/^Date: +(\d{4}-\d{2}-\d{2})/)
            current_date = matched_data[1]
            if options[:verbose] || previous_date != current_date
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
        File.open(output_filename, 'w+') do |file|
          YAML.dump(@collector, file)
        end
      ensure
        `cd #{input_directory} && #{git} checkout master`
      end
      
      if options[:graph]
        graph(output_filename)
      end
    else
      puts "Unable to proceed with stat check. Uncommited changes found in #{input_directory}"
      exit!(-1)
    end
  end

  def self.graph(input_file)
    input = YAML.load_file(input_file)
    lines_of_test_code = []
    lines_of_code = []
    input.each {|input| 
      lines_of_test_code << input[:lines_of_test_code]
      lines_of_code << input[:lines_of_code]
    }
    upper_limit = [lines_of_test_code.max, lines_of_code.max].max

    url_query_elements = []
    url_query_elements << "cht=lc" # Line chart
    url_query_elements << "chs=525x525" # chart size
    url_query_elements << "chds=0,#{upper_limit}" # chart data scale
    url_query_elements << "chd=t:#{lines_of_code.reverse.join(',')}\\\|#{lines_of_test_code.reverse.join(',')}" #chart data
    url_query_elements << "chxt=y" # chart axis
    url_query_elements << "chdl=LOC\\\|TLOC"
    url_query_elements << "chco=FF0000,0000FF"

    labels = [0]
    i = 0
    while i < upper_limit do
      i += 500
      labels << i
    end 
    url_query_elements << "chxl=0:\\\|#{labels.join("\\\|")}" # chart axis
    url = "http://chart.apis.google.com/chart?#{url_query_elements.join("\\\&")}"
    puts url
    `open #{url}`
  end
end
