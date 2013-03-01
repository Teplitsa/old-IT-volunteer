# encoding: utf-8

module InplaceHelper

  def inplace_editable_link_to(object, attribute, params = {}, &block)
    title = object.send(attribute) || '' if not block_given?

    p = {}
    p['data-name'] = attribute
    p['data-type'] = :text
    p['data-resource'] = params.fetch(:resource, object.class.name.downcase) 
    p['class'] = 'x-editable-inplace'.concat params.fetch(:class, '')
    p['data-url'] = polymorphic_path(object)
    p['data-original-title'] = params.fetch(:title, t("inplace_editable.#{attribute}", default: "Введите #{ attribute }") )
    p['data-emptytext'] = params.fetch(:emptytext, 'добавить')

    if not block_given?
      link_to title, '#', p
    else
      link_to '#', p, &block
    end
  end

end