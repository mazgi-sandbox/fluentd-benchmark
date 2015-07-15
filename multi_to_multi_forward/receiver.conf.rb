ports=(20000..20107)
puts <<EOC
<source>
  type multiprocess
EOC
ports.each do |port|
puts <<EOC
  <process>
    cmdline -i "<source>\\ntype forward\\nport #{port}\\n</source>" -c flowcounter.conf --log /tmp/receiver.log
    sleep_before_start 0s
    sleep_before_shutdown 0s
  </process>
EOC
end
puts <<EOC
</source>
EOC
