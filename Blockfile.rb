require 'web_blocks/facade/external_component_block'

register_facade :external_component_block, ::WebBlocks::Facade::ExternalComponentBlock

external_component_block 'Chart.js', path: 'src' do

  dependency framework.route 'Chart.js-color'

  core = block 'core', path: 'core' do

    core = block 'core' do
      js_file 'core.js'
    end

    core_helpers = block 'helpers' do
      dependency core.route
      js_file 'core.helpers.js'
    end

    core_element = block 'element' do
      dependency core_helpers.route
      js_file 'core.element.js'
    end

    ['animation', 'controller', 'scale', 'scaleService', 'tooltip'].each do |name|
      block name do
        dependency core_element.route
        js_file "core.#{name}.js"
      end
    end

  end

  controllers = block 'controllers', path: 'controllers' do
    dependency core.route
    ['bar','doughnut','line','polarArea','radar'].each do |name|
      block(name){ js_file "controller.#{name}.js" }
    end
  end

  scales = block 'scales', path: 'scales' do
    dependency core.route
    ['category','linear','logarithmic','radialLinear','time'].each do |name|
      block(name){ js_file "scale.#{name}.js" }
    end
  end

  elements = block 'elements', path: 'elements' do
    dependency core.route
    ['arc','line','point','rectangle'].each do |name|
      block(name){ js_file "element.#{name}.js" }
    end
  end

  block 'charts', path: 'charts' do
    dependency core.route
    dependency scales.route
    dependency elements.route
    ['bar','doughnut','line','polarArea','radar'].each do |name|
      block(name) do
        dependency controllers.route name
        js_file "Chart.#{name.capitalize}.js"
      end
    end
  end

end