module ArticlesHelper

  def kramdown_to_html(s, images)
    Kramdown::Document.new(
      raspberry_markdown_to_html(s, images),
      { input: "Kramdown", parse_block_html: true, parse_span_html: true }
    ).to_html
  end

  def raspberry_markdown_to_html(s, images)
    s = replace_includes(s)
    s = replace_image_paths(s, images)
    s = replace_resource_paths(s, images)
    s = replace_hints(s)
    s = replace_collapsibles(s)
    s = remove_tasks(s)
    s = remove_challenges(s)
    s = remove_prints(s)
    s = remove_print_onlys(s)
    s = s.gsub("```", "~~~")
  end

  def replace_image_paths(s, images)
    image_blob_regex = /\/([\w|-]+.[\w]+)\z/

    image_blobs = images.map do |image|
      [
        image_blob_regex.match(Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)).to_a.second,
        Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
      ]
    end.to_h

    image_path_regex = /]\(images\/([\w|\.|-]*)\)/m

    s.scan(image_path_regex).each do |image_path|
      s = s.gsub("images/#{image_path.first}", "#{image_blobs[image_path.first]}")
    end

    s
  end

  def replace_resource_paths(s, resources)
    resource_blob_regex = /\/([\w|-]+.[\w]+)\z/

    resource_blobs = resources.map do |resource|
      [
        resource_blob_regex.match(Rails.application.routes.url_helpers.rails_blob_path(resource, only_path: true)).to_a.second,
        Rails.application.routes.url_helpers.rails_blob_path(resource, only_path: true)
      ]
    end.to_h

    resource_path_regex = /]\(resources\/([\w|\.|-]*)\)/m

    s.scan(resource_path_regex).each do |resource_path|
      s = s.gsub("resources/#{resource_path.first}", "#{resource_blobs[resource_path.first]}")
    end

    s
  end

  def replace_includes(s)
    include_regex = /\[\[\[([\w|-]*)\]\]\]/m

    s.scan(include_regex).each do |include_key|
      article = Article.find_by(key: include_key.first)
      if article.present?
        include_content = """<ul class='collapsible'>
          <li>
            <div class='collapsible-header'><i class='material-icons blue-text'>info</i>#{article.title}</div>
            <div class='collapsible-body' markdown='1'>#{replace_image_paths(article.body, article.images)}</div>
          </li>
        </ul>
        """
      else
        include_content = "ARTICLE NOT FOUND!"
      end
      s = s.gsub("[[[#{include_key.first}]]]", include_content)
    end

    s
  end

  def replace_hints(s)
    s.gsub("--- hints ---", "<div class='carousel carousel-slider' markdown='0'>")
      .gsub("--- hint ---", "<div class='carousel-item red white-text' style='padding: 50px;' markdown='1'>")
      .gsub("--- /hint ---", "</div>")
      .gsub("--- /hints ---", "<div class='carousel-fixed-item'>
      <a class='previous-carousel left btn-floating waves-effect btn-pirate-skyblue white-text'><i class='material-icons'>arrow_back</i></a>
      <a class='next-carousel right btn-floating waves-effect btn-pirate-skyblue white-text'><i class='material-icons'>arrow_forward</i></a>
    </div></div>")
  end

  def remove_tasks(s)
    s.gsub("--- task ---", "").gsub("--- /task ---", "")
  end

  def remove_challenges(s)
    s.gsub("--- challenge ---", "").gsub("--- /challenge ---", "")
  end

  def remove_prints(s)
    s.gsub("--- no-print ---", "<div class='no-print'>").gsub("--- /no-print ---", "</div>")
  end

  def remove_print_onlys(s)
    s.gsub("--- print-only ---", "<div class='print-only'>").gsub("--- /print-only ---", "</div>")
  end

  def replace_collapsibles(s)
    collapsible_regex = /--- collapse ---.*--- \/collapse ---/m
    collapsibles = collapsible_regex.match(s).to_a

    collapsibles.each do |collapsible|
      s = s.gsub(collapsible, collapsible_to_html(collapsible))
    end
    s
  end

  private

  def collapsible_to_html(s)
    collapsible_tag_start = "<ul class='collapsible'><li>"
    collapsible_title_tag_start = "<div class='collapsible-header'><i class='material-icons blue-text'>info</i>"
    collapsible_title_tag_end = "</div><div class='collapsible-body' markdown='1'>"
    collapsible_tag_end = "</div></li></ul>"
    title_start =
"""
---
title:"""

    s.gsub("--- collapse ---", collapsible_tag_start)
      .gsub("--- /collapse ---", collapsible_tag_end)
      .gsub(title_start, collapsible_title_tag_start)
      .gsub("---\r\ntitle: ", collapsible_title_tag_start)
      .gsub("---", collapsible_title_tag_end)
  end
end
