require "rails_helper"

describe ArticlesHelper do
  describe "#raspberry_markdown_to_html" do
    let(:text) { "" }
    let(:subject) { helper.raspberry_markdown_to_html(text) }

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
<ul class='collapsible'><li><div class='collapsible-header'><i class='material-icons'>Info</i> What you will learn
</div><div class='collapsible-body'><span>
stuff
</span></div></li></ul>
rawr
"""
        expect(subject).to eq(result)
      end
    end

    context "text has target blank attributes" do
      let(:text) { "This project covers [Curriculum](http://rpf.io/curriculum){:target=\"_blank\"}" }
      it "removes target blank attribute" do
        result = "This project covers [Curriculum](http://rpf.io/curriculum)"
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
```bash
cd webapp
```


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
![screenshot](images/coder-hint-er.png)
--- /hint --- --- /hints ---
"""
      end

      it "replaces hints with html carousels" do
        result =
"""
<div class='carousel'> <a class='carousel-item'>
You need to click the + on the union block to add space for two more letters.
</a> <a class='carousel-item'>
You can duplicate the code you used to create a 'D' and then change the letters and the X values.
</a> <a class='carousel-item'>
![screenshot](images/coder-hint-er.png)
</a> </div>
"""
        expect(subject).to eq(result)
      end
    end
  end
end
