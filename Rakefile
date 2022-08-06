desc 'Run the DVLA Rubocop Ruby linting rules'

task :lint do
  sh 'rubocop -a'
end

task run_tests: 'lint' do
  sh 'cucumber'
end
