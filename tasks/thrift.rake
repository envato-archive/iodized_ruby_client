namespace :thrift do
  desc "generate thrift boilerplate"
  task :generate do
    puts exec("thrift -out lib/iodized -gen rb -verbose thrift/feature.thrift")
  end
end

