module ArticlesHelper

  def raspberry_markdown_to_html(s, images)
    s = replace_image_paths(s, images)
    s = replace_includes(s)
    s = replace_hints(s)
    s = replace_collapsibles(s)
    s = remove_tasks(s)
    s = remove_prints(s)
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
      s = s.gsub("](images/#{image_path.first})", "](#{image_blobs[image_path.first]})")
    end

    s
  end

  def replace_includes(s)
    include_regex = /\[\[\[([\w|-]*)\]\]\]/m

    s.scan(include_regex).each do |include_key|
      article = Article.find_by(key: include_key.first)
      s = s.gsub("[[[#{include_key.first}]]]", article.present? ? replace_image_paths(article.body, article.images) : "ARTICLE NOT FOUND!")
    end

    s
  end

  def replace_hints(s)
    s.gsub("--- hints ---", "<div class='carousel carousel-slider' markdown='0'>")
      .gsub("--- hint ---", "<div class='carousel-item red white-text' style='padding: 5px;' markdown='1'>")
      .gsub("--- /hint ---", "</div>")
      .gsub("--- /hints ---", "</div>")
  end

  def remove_tasks(s)
    s.gsub("--- task ---", "").gsub("--- /task ---", "")
  end

  def remove_prints(s)
    s.gsub("--- no-print ---", "").gsub("--- /no-print ---", "")
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
