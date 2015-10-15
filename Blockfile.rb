external_component_block 'Chart.js', path: 'src' do

  dependency framework.route 'moment'

  core = block 'core' do
    js_file 'Chart.Core.js'
  end

  block 'charts' do
    dependency core.route
    ['bar','doughnut','line','polarArea','radar'].each do |name|
      block(name){ js_file "Chart.#{name.capitalize}.js" }
    end
  end

end