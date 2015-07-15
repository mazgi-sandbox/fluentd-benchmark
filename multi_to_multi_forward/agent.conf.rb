host=ENV['RCV_HOST']
ports=(20000..20107)
num_threads=((ports.max - ports.min) * 0.6).to_i
num_threads=1 if num_threads==0
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
    heartbeat_interval 60s
    flush_interval 0
    buffer_chunk_limit 1m
    buffer_queue_limit 64
    num_threads #{num_threads}
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
