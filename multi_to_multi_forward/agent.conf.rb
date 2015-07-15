host="127.0.0.1"
ports=(20000..20107)
puts <<EOC
<source>
  type tail
  path /tmp/dummy.log
  pos_file /var/tmp/_var_log_dummy.pos
  format none
  tag dummy
</source>
<match dummy>
  type copy
  <store>
    type forward
    flush_interval 0
    buffer_chunk_limit 1m
    buffer_queue_limit 64
    num_threads 128
EOC
ports.each do |port|
puts <<EOC
    <server>
      host #{host}
      port #{port}
    </server>
EOC
end
puts <<EOC
  </store>
  <store>
    type flowcounter_simple
    unit second
  </store>
</match>
EOC
