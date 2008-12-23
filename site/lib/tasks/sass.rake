require 'fileutils'

namespace :sass do
  desc "Generate syntax highlight files for sass files in this project."
  task :pygmentize do
    sass_files = FileList.new('app/stylesheets/**/*.sass')
    sass_files.each do |file|
      target = file.gsub("app/stylesheets", "public/highlighted/stylesheets")+".html"
      FileUtils.mkdir_p(File.dirname(target))
      puts "Writing #{target}"
      sh "pygmentize -O linenos=table -o #{target} #{file}"
    end
  end

  desc "Make import directives link to the corresponding syntax hightlighted sass file."
  task :link_imports => :pygmentize do
    require 'hpricot'
    require 'sass'
    hightlight_files = FileList.new('public/highlighted/stylesheets/**/*.sass.html')
    hightlight_files.each do |file|
      puts "Adding links to #{file}"
      doc = open(file) {|f| Hpricot(f.read) }
      doc.search("span.nn") do |span|
        puts "Checking if #{span.inner_text} exists."
        local_dir = "app/stylesheets/#{File.dirname(file)[31..-1]}"
        puts local_dir
        if full_path = Sass::Engine.find_full_path(span.inner_text, ["app/stylesheets", local_dir])
          puts "Found #{span.inner_text} at #{full_path}"
          wrapped = span.make(%Q{<a class="import" href="/hl/#{full_path[16..-1]}">#{span}</a>})
          span.parent.replace_child(span, wrapped)
        end
      end
      open(file, 'w') do |file|
        file.write doc.to_s
      end
    end
  end

  task :highlight => :link_imports
end