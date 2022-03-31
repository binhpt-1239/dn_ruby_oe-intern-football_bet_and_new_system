module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title = ""
    base_title = t "title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def link_to_add_row name, form, association, **args
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for(association, new_object, child_index: id) do |p|
      render(association.to_s.singularize + "_fields", f: p)
    end
    link_to name, "#", class: "add_fields " + args[:class],
      data: {id: id, fields: fields.gsub("\n", "")}
  end
end
