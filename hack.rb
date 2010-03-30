$LOAD_PATH << 'lib'

require 'dimensions'

def check_ref( ref)
  @dataset.lookup( ref).path
end

@dataset = Dimensions::Metadata.read( 'spec/fixtures/P4550054.mdd')

#p @dataset.loop_designs.find {|l| l.name == 'GRQ9' }.mddclass.field.variables.map( &:name)
#p @dataset.node.xpath( 'design/fields/loop/class/fields/variable[2]').size

#p @dataset.loop_designs.find {|l| l.name == 'LoopQ27ToQ29' }.mddclass.field.node
#p @dataset.loop_designs.find {|l| l.name == 'GRQ9' }.mddclass.field.node
  # @name='@fields' global-name-space='-1'
  # <variable id='guid' name='Q9' ref='guid' />
#p @dataset.loop_designs.find {|l| l.name == 'LoopQ30ToQ31' }.mddclass.field.node
  # @name='@fields' global-name-space='-1'
  # <variable id='guid' name='Q30POS' ref='guid' />
  # <variable id='guid' name='Q31NEG' ref='guid' />

#p @dataset.loop_designs.find {|l| l.name == 'GRQ9' }.mddclass.field.variables.first.ref.node
%q{<variable id="711be68b-f561-435f-a442-dde3e677a4f7" name="Q9" type="3" min="1" mintype="3" max="1" maxtype="3">
  <labels context="LABEL"><text context="QUESTION" xml:lang="en-US"/></labels>
  <categories global-name-space="-1">
    <category id="_a3a920a4-95b9-465e-8554-9af69dd5bc2a" name="_01">
      <labels context="LABEL"><text context="QUESTION" xml:lang="en-US">Once a day</text></labels>
    </category>
    <category id="_1ebdc5ae-8e61-46e6-9880-1aac5425c730" name="_02">
      <labels context="LABEL"><text context="QUESTION" xml:lang="en-US">A few times a week</text></labels>
    </category>
    <category id="_24c5d80f-ff0c-4bd2-9052-b2068d2d097c" name="_03">
      <labels context="LABEL"><text context="QUESTION" xml:lang="en-US">Once a week</text></labels>
    </category>
    <category id="_f30e5930-bd7c-4299-88d7-56e1fbae08b7" name="_04">
      <labels context="LABEL"><text context="QUESTION" xml:lang="en-US">A few times a month</text></labels>
    </category>
    <category id="_2bda1b6f-545d-4588-8214-9ba13a5caad9" name="_05">
      <labels context="LABEL"><text context="QUESTION" xml:lang="en-US">Once a month or less</text></labels>
    </category>
    <category id="_2406e16f-b117-4fe1-bdd8-4334de535be2" name="_06">
      <labels context="LABEL"><text context="QUESTION" xml:lang="en-US">Never</text></labels>
    </category>
    <category id="_b95780ac-46bc-421e-b39b-931649fae94d" name="_07">
      <labels context="LABEL"><text context="QUESTION" xml:lang="en-US">Don&#x2019;t know</text></labels>
    </category>
  </categories>
  <helperfields/>
</variable>}
p @dataset.loop_designs.find {|l| l.name == 'LoopQ30ToQ31' }.mddclass.field.variables.first.ref.node
%q{<variable id="31692551-9fd9-4cfa-b2c8-8affece3f817" name="Q30POS" type="2" min="1" mintype="3">
  <labels context="LABEL"><text context="QUESTION" xml:lang="en-US">&lt;table width='898px' bgcolor='#c6D0E9' cellspacing='0' cellpadding='5'&gt;&lt;tr&gt;&lt;td&gt;Looking at this statement again, &lt;u&gt;{#\.fhi}please highlight the words or phrases{#\.fes}&lt;/u&gt; that make you feel &lt;u&gt;{#\.fhi}more positive towards Sara Lee{#\.fes}&lt;/u&gt;.&lt;p/&gt;To highlight a word or section of the text, simply click on the first word that you wish to highlight with your mouse, and drag your mouse to the end of the word or section of the text that you want to highlight &#x2013; then release the mouse button.  If you make a mistake, and want to un-highlight a word or section of the text, simply click on that highlighted section of the text to remove the highlight.&lt;p/&gt;When all of the words or sections of text that you wish to highlight have been selected, click the &#x201C;Next&#x201D; button below to continue.&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;&lt;p/&gt;&lt;table width='898px' bgcolor='#c6D0E9' cellspacing='0' cellpadding='5'&gt;&lt;tr&gt;&lt;td&gt;&lt;div id='stm1' class='mercuryanalytics_text_selector' &gt;{@}&lt;/div&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;</text></labels>
  <helperfields id="7f98f6a9-ea48-49ff-98ad-fd276c42ec43" name="@helperfields" global-name-space="-1">
    <class id="_5542e352-16dc-4c56-b595-5f6681dcef43" name="StandardTexts" global-name-space="0">
      <labels context="LABEL"><text context="QUESTION" xml:lang="en-US">StandardTexts</text></labels>
      <types name="@types" global-name-space="-1"/>
      <fields name="@fields" global-name-space="-1">
        <class id="_a32f5615-b125-407f-8692-15d6f1231dd5" name="Errors" global-name-space="0">
          <labels context="LABEL"><text context="QUESTION" xml:lang="en-US">Errors</text></labels>
          <types name="@types" global-name-space="-1">
          </types>
          <fields name="@fields" global-name-space="-1">
            <variable id="_53b9d805-2453-4af8-96c3-1050048df44e" name="MissingAnswer" ref="53b9d805-2453-4af8-96c3-1050048df44e"/>
            <variable id="_62752dda-b996-419d-b04c-0f733e646e61" name="NotSingleAnswer" ref="62752dda-b996-419d-b04c-0f733e646e61"/>
          </fields>
          <pages name="@pages" global-name-space="-1">
          </pages>
        </class>
      </fields>
      <pages name="@pages" global-name-space="-1"/>
    </class>
    <variable id="_da8b9bc8-d6f7-4114-9d5d-82d81defa52e" name="Codes" ref="da8b9bc8-d6f7-4114-9d5d-82d81defa52e"/>
  </helperfields>
  <categories/>
</variable>}

#raise "Still need to figure out LoopQ30ToQ31[{A}].Q30POS vs LoopQ30ToQ31[{A}].Q30POS.Codes"

def variable( name)
  @dataset.variable_definitions.find {|x| x.name == name }
end

def interpret_variable( vdef)
  case vdef.type
  when :integer
    "integer #{vdef.rangeexp}"
  when :category
    cats = vdef.categories.first
    until cats.nil? || cats.category_set_present?
      if cats.categoriesref
	cats = cats.categoriesref
      else
	cats = cats.categories.first
      end
    end
    build_category_map( cats.category_set)
  when :text
    "open-end min=#{vdef.min}, max=#{vdef.max}"
  when 0
    if vdef.labels_present?
      "type0: #{vdef.label.text}"
    else
      "type0: no label"
    end
  else
    "unknown #{vdef.type.inspect}"
  end
end

def interpret_loop( design)
  return "unknown (#{design.iteratortype},#{design.node['type']})" unless design.iteratortype == '2' && design.node[ 'type'] == '1'
  build_category_map( design.categories.first.category_set)	# how do I know we're looping over a category?
end

def build_category_map( cat)
  Hash[ cat.map {|c| [ c.name, [ c.label.text.value, @dataset.category_map[ c.name] ] ] } ].inspect
end

#@dataset.variable_designs.each do |design|
#  vdef = design.definition
#  puts "#{design.name}: #{interpret_variable( vdef)}" if vdef.casedata? && vdef.type != :static
#end

#@dataset.loop_designs.each do |design|
#  puts "Loop #{design.name}: #{interpret_loop( design)}"
#end

def simple_label_set( name)
  variable( name).categories.first.category_set.map {|c| [ c.name, c.label.text.value ] }
end

#p variable( 'Q1').categories.first.categories.first.categoriesref.category_set.map {|c| [ c.name, c.label.text.value ] }
#p simple_label_set( 'Q2')
#p simple_label_set( 'Q3')
#p simple_label_set( 'Q4')
#p simple_label_set( 'Q5')
#p simple_label_set( 'Q6')
#p simple_label_set( 'Q7')
#p simple_label_set( 'Q8')
#p simple_label_set( 'Q9')
#p simple_label_set( 'Q10')
#p simple_label_set( 'Q11')
#p variable( 'Q12').type # is an empty question with a range of 0..100
#p simple_label_set( 'Q13')
#p variable( 'Q14').label.text.value # is an integer question with range of 0..100
#p simple_label_set( 'Q15')
#p simple_label_set( 'Q16')
#p simple_label_set( 'Q17')
#p simple_label_set( 'Q18')
#p simple_label_set( 'Q19')
#p simple_label_set( 'Q20')
#p simple_label_set( 'Q21')
#p simple_label_set( 'Q22')
#p simple_label_set( 'Q23')
#p simple_label_set( 'Q24')
#p simple_label_set( 'Q25')
#p simple_label_set( 'Q26')
#p simple_label_set( 'Q27')
#p simple_label_set( 'Q28')
#p simple_label_set( 'Q29')
#p variable( 'Q30') -- doesn't exist
#p variable( 'Q31') -- doesn't exist
#p variable( 'Q32').label.text.value # is an integer question with range of 0..100
#p simple_label_set( 'Q33')
#p simple_label_set( 'Q34')
#p simple_label_set( 'Q35')
#p simple_label_set( 'Q36')

#nodes = @dataset.node.xpath( './/categories/categories')
#p nodes.map {|x| x.parent.name }.sort.uniq
#puts nodes.map( &:path)
#puts nodes
#puts nodes.map( &:attributes).map( &:inspect)
#_nodes = nodes.map { |x| Dimensions::Node.new( x, @dataset.ids) }
#puts _nodes.map( &:immediate_children).map( &:inspect)
#puts _nodes.map {|n| check_ref( n.ref) }
