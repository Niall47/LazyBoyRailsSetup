def load(filename)
	file = File.open(filename)
	count = 0	
	file.each_with_index(filename) { |line, linenum| 
		line.each_line do |short_line|
		count += 1
			p "Found #{filename} at line # #{count}" if compare?(short_line)
		end	
	}
end

def compare?(line)
	line.include?(@keyword)
end

def check_directory
  directory = Dir['**/*'].reject {|fn| File.directory?(fn) } #List all files
  p "Searching for #{@keyword} through #{directory.count} files"
  directory.each do |name|
    unless name.include?("~") #file is probably open so we're skipping it
		load(name)
	end	
  end
end

$results = Hash.new
p 'Enter the keyword to search for'
@keyword = gets.strip 
check_directory

