require "jekyll-spark"

module Jekyll
  class CardComponent < ComponentBlock
    def template(context)
      # Declare props as variables
      # Not necessary, but highly recommended

      content = @props["content"]
      url = @props["url"]
      title = @props["title"]
      text_color = @props["text_color"]
      image = "assets/img/" + @props["image"]
      text_color_dark = @props["text_color_dark"]
      image_dark = @props["image_dark"]

      id = title.delete(' ').downcase + "-id"

      if image_dark != nil
            image_dark = "assets/img/" + image_dark
            render = %Q[
                <style>
                ##{id} 
                {
                    color:#{text_color};
                    background-image: url('#{image}');
                } 
                @media (prefers-color-scheme: dark)
                {
                    ##{id} 
                    {
                        color:#{text_color_dark};
                        background-image: url('#{image_dark}');
                    }
                }
                </style>
                <a href="#{url}" class="card" id="#{id}">
                    <div>
                        <h3>#{title}</h3>
                        <p>#{content}</p>
                    </div>
                </a>
              ]
      else
        if text_color != nil
            render = %Q[
                <a href="#{url}" class="card" style="color:#{text_color};background-image: url('#{image}');">
                        <div>
                        <h3>#{title}</h3>
                        <p>#{content}</p>
                        </div>
                    </a>
          
                ]
        else 
            render = %Q[
                <a href="#{url}" class="card" style="background-image: url('#{image}');">
                        <div>
                        <h3>#{title}</h3>
                        <p>#{content}</p>
                        </div>
                    </a>
              ]
        end 
      end
    end
  end
end

Liquid::Template.register_tag(
  "Card",
  Jekyll::CardComponent,
)