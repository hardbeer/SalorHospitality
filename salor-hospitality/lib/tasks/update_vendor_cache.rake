# Copyright (c) 2012 Red (E) Tools Ltd.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

desc 'Configures this instance'
# Call like: rake salor_configure['saas']
task :salor_configure, [:mode] => :environment do |t, args|
  Vendor.all.each do |v|
    puts "Updating cache of Vendor #{v.id}"
    v.update_cache
  end
  
  puts :mode.inspect
  
  subdomain = ENV['SH_DEBIAN_SITEID'] ? "#{ENV['SH_DEBIAN_SITEID']}.sh" : nil
  
  unless Company.where(:subdomain => subdomain).any?
    puts "No company with subdomain #{subdomain} found. Updating last company that has a subdomain of nil."
    Company.where(:subdomain => nil).last.update_attributes :mode => args[:mode], :subdomain => subdomain
  end
end


