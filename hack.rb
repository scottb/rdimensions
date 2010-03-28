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
%{<variable id="711be68b-f561-435f-a442-dde3e677a4f7" name="Q9" type="3" min="1" mintype="3" max="1" maxtype="3">
  <labels context="LABEL">
    <versions>
      <DIFF OP="ADD" name="1" Index="0">
        <text context="QUESTION" xml:lang="en-US"/>
      </DIFF>
    </versions>
    <text context="QUESTION" xml:lang="en-US"/>
  </labels>
  <categories global-name-space="-1">
    <versions>
      <DIFF OP="ADD" name="1" Index="0" item="a3a920a4-95b9-465e-8554-9af69dd5bc2a"/>
      <DIFF OP="ADD" name="1" Index="1" item="1ebdc5ae-8e61-46e6-9880-1aac5425c730"/>
      <DIFF OP="ADD" name="1" Index="2" item="24c5d80f-ff0c-4bd2-9052-b2068d2d097c"/>
      <DIFF OP="ADD" name="1" Index="3" item="f30e5930-bd7c-4299-88d7-56e1fbae08b7"/>
      <DIFF OP="ADD" name="1" Index="4" item="2bda1b6f-545d-4588-8214-9ba13a5caad9"/>
      <DIFF OP="ADD" name="1" Index="5" item="2406e16f-b117-4fe1-bdd8-4334de535be2"/>
      <DIFF OP="ADD" name="1" Index="6" item="b95780ac-46bc-421e-b39b-931649fae94d"/>
      <version name="1">
        <categories global-name-space="-1"/>
      </version>
    </versions>
    <deleted/>
    <category id="_a3a920a4-95b9-465e-8554-9af69dd5bc2a" name="_01">
      <labels context="LABEL">
        <versions>
          <DIFF OP="ADD" name="1" Index="0">
            <text context="QUESTION" xml:lang="en-US">Once a day</text>
          </DIFF>
        </versions>
        <text context="QUESTION" xml:lang="en-US">Once a day</text>
      </labels>
      <versions>
        <version name="1">
          <category name="_01"/>
        </version>
      </versions>
      <properties/>
    </category>
    <category id="_1ebdc5ae-8e61-46e6-9880-1aac5425c730" name="_02">
      <labels context="LABEL">
        <versions>
          <DIFF OP="ADD" name="1" Index="0">
            <text context="QUESTION" xml:lang="en-US">A few times a week</text>
          </DIFF>
        </versions>
        <text context="QUESTION" xml:lang="en-US">A few times a week</text>
      </labels>
      <versions>
        <version name="1">
          <category name="_02"/>
        </version>
      </versions>
      <properties/>
    </category>
    <category id="_24c5d80f-ff0c-4bd2-9052-b2068d2d097c" name="_03">
      <labels context="LABEL">
        <versions>
          <DIFF OP="ADD" name="1" Index="0">
            <text context="QUESTION" xml:lang="en-US">Once a week</text>
          </DIFF>
        </versions>
        <text context="QUESTION" xml:lang="en-US">Once a week</text>
      </labels>
      <versions>
        <version name="1">
          <category name="_03"/>
        </version>
      </versions>
      <properties/>
    </category>
    <category id="_f30e5930-bd7c-4299-88d7-56e1fbae08b7" name="_04">
      <labels context="LABEL">
        <versions>
          <DIFF OP="ADD" name="1" Index="0">
            <text context="QUESTION" xml:lang="en-US">A few times a month</text>
          </DIFF>
        </versions>
        <text context="QUESTION" xml:lang="en-US">A few times a month</text>
      </labels>
      <versions>
        <version name="1">
          <category name="_04"/>
        </version>
      </versions>
      <properties/>
    </category>
    <category id="_2bda1b6f-545d-4588-8214-9ba13a5caad9" name="_05">
      <labels context="LABEL">
        <versions>
          <DIFF OP="ADD" name="1" Index="0">
            <text context="QUESTION" xml:lang="en-US">Once a month or less</text>
          </DIFF>
        </versions>
        <text context="QUESTION" xml:lang="en-US">Once a month or less</text>
      </labels>
      <versions>
        <version name="1">
          <category name="_05"/>
        </version>
      </versions>
      <properties/>
    </category>
    <category id="_2406e16f-b117-4fe1-bdd8-4334de535be2" name="_06">
      <labels context="LABEL">
        <versions>
          <DIFF OP="ADD" name="1" Index="0">
            <text context="QUESTION" xml:lang="en-US">Never</text>
          </DIFF>
        </versions>
        <text context="QUESTION" xml:lang="en-US">Never</text>
      </labels>
      <versions>
        <version name="1">
          <category name="_06"/>
        </version>
      </versions>
      <properties/>
    </category>
    <category id="_b95780ac-46bc-421e-b39b-931649fae94d" name="_07">
      <labels context="LABEL">
        <versions>
          <DIFF OP="ADD" name="1" Index="0">
            <text context="QUESTION" xml:lang="en-US">Don&#x2019;t know</text>
          </DIFF>
        </versions>
        <text context="QUESTION" xml:lang="en-US">Don&#x2019;t know</text>
      </labels>
      <versions>
        <version name="1">
          <category name="_07"/>
        </version>
      </versions>
      <properties/>
    </category>
    <properties/>
  </categories>
  <versions>
    <version name="1">
      <variable name="Q9" type="3" min="1" mintype="3" max="1" maxtype="3"/>
    </version>
  </versions>
  <helperfields/>
  <properties/>
</variable>}
p @dataset.loop_designs.find {|l| l.name == 'LoopQ30ToQ31' }.mddclass.field.variables.first.ref.node
%q{

}

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
