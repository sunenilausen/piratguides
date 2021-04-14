require "rails_helper"

describe ArticlesHelper do
  describe "#raspberry_markdown_to_html" do
    let(:text) { "" }
    let(:subject) { helper.raspberry_markdown_to_html(text, []) }

    context "text has collapsible markdown" do
      let(:text) do
"""
rawr
--- collapse ---
---
title: What you will learn
---
stuff
--- /collapse ---
rawr
"""
      end

      it "replaces collapsible with html" do
        result =
"""
rawr
<ul class='collapsible'><li><div class='collapsible-header'><i class='material-icons blue-text'>info</i> What you will learn
</div><div class='collapsible-body' markdown='1'>
stuff
</div></li></ul>
rawr
"""
        expect(subject).to eq(result)
      end
    end

    context "text has tasks" do
      let(:text) do
"""
--- task ---
Use the 'change directory' command `cd` to open the new directory.
```bash
cd webapp
```
--- /task ---
--- task ---
Open Python 3 IDLE, and create a new file by clicking on**File** and then on **New file**.
--- /task ---
"""
      end

      it "removes task keywords" do
        result =
"""

Use the 'change directory' command `cd` to open the new directory.
~~~bash
cd webapp
~~~


Open Python 3 IDLE, and create a new file by clicking on**File** and then on **New file**.

"""
        expect(subject).to eq(result)
      end
    end

    context "text has hints" do
      let(:text) do
"""
--- hints --- --- hint ---
You need to click the + on the union block to add space for two more letters.
--- /hint --- --- hint ---
You can duplicate the code you used to create a 'D' and then change the letters and the X values.
--- /hint --- --- hint ---
![screenshot](custom_images/coder-hint-er.png)
--- /hint --- --- /hints ---
"""
      end

      it "replaces hints with html carousels" do
        result =
"""
<div class='carousel carousel-slider' markdown='0'> <div class='carousel-item red white-text' style='padding: 5px;' markdown='1'>
You need to click the + on the union block to add space for two more letters.
</div> <div class='carousel-item red white-text' style='padding: 5px;' markdown='1'>
You can duplicate the code you used to create a 'D' and then change the letters and the X values.
</div> <div class='carousel-item red white-text' style='padding: 5px;' markdown='1'>
![screenshot](custom_images/coder-hint-er.png)
</div> </div>
"""
        expect(subject).to eq(result)
      end
    end

    context "text has includes" do
      let!(:article) { Article.find_or_create_by(title: "Pip install", key: "generic-python-installing-with-pip", body: "Go to pip.org") }
      let!(:article_2) { Article.find_or_create_by(title: "Python install", key: "generic-python-install", body: "Go to python.org") }
      let(:text) do
        """
        Install Python
        [[[generic-python-install]]]

        Install the `flask` Python module using `pip`. Make sure you are connected to the internet before you start.

        [[[generic-python-installing-with-pip]]]
        """
      end

      it "replaces triple brackets with article content" do
        expect(subject).to include(article.body)
        expect(subject).to include(article_2.body)
      end
    end
  end
end
