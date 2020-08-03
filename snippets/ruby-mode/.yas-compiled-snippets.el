;;; Compiled snippets and support files for `ruby-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'ruby-mode
		     '(("{" "{ |${1:variable}| $0 }" "{ |variable| ... }" nil
			("Blocks")
			nil "~/dot.emacs/snippets/ruby-mode/{" nil nil)
		       ("zip" "zip(${enums}) { |${row}| $0 }" "zip(...) { |...| ... }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/zip" nil nil)
		       ("y" ":yields: $0" ":yields: arguments (rdoc)" nil nil nil "~/dot.emacs/snippets/ruby-mode/y" nil nil)
		       ("xpa" "elements.each(\"${1://XPath}\") do |${2:node}|\n  $0\nend" "xpath(..) { .. }" nil nil nil "~/dot.emacs/snippets/ruby-mode/xpa" nil nil)
		       ("xml-" "REXML::Document.new(File.read(${1:\"${2:path/to/file}\"}))" "xml-" nil nil nil "~/dot.emacs/snippets/ruby-mode/xml-" nil nil)
		       ("while" "while ${condition}\n  $0\nend" "while ... end" nil
			("Loops")
			nil "~/dot.emacs/snippets/ruby-mode/while" nil nil)
		       ("when" "when ${1:condition}\n  $0" "when ..." nil
			("Conditions")
			nil "~/dot.emacs/snippets/ruby-mode/when" nil nil)
		       ("w" "attr_writer :" "attr_writer ..." nil nil nil "~/dot.emacs/snippets/ruby-mode/w" nil nil)
		       ("vu" "validates_uniqueness_of :${attr}\n" "validates_uniqueness_of : ..." nil
			("ActiveRecord")
			nil "~/dot.emacs/snippets/ruby-mode/vu" nil nil)
		       ("vp" "validates_presence_of :${attr}" "validates_presence_of : ..." nil
			("ActiveRecord")
			nil "~/dot.emacs/snippets/ruby-mode/vp" nil nil)
		       ("vn" "validates_numericality_of :${attr}\n" "validates_numericality_of : ..." nil
			("ActiveRecord")
			nil "~/dot.emacs/snippets/ruby-mode/vn" nil nil)
		       ("vi" "validates_inclusion_of :${attr}" "validates_inclusion_of : ..." nil
			("ActiveRecord")
			nil "~/dot.emacs/snippets/ruby-mode/vi" nil nil)
		       ("vf" "validates_format_of :${attr}, :with => /${regex}/\n" "validates_format_of : ... , :with => / ... /" nil
			("ActiveRecord")
			nil "~/dot.emacs/snippets/ruby-mode/vf" nil nil)
		       ("ve" "validates_exclusion_of :${attr}\n" "validates_exclusion_of : ..." nil
			("ActiveRecord")
			nil "~/dot.emacs/snippets/ruby-mode/ve" nil nil)
		       ("vc" "validates_confirmation_of :${attr}\n" "validates_confirmation_of : ..." nil
			("ActiveRecord")
			nil "~/dot.emacs/snippets/ruby-mode/vc" nil nil)
		       ("va" "validates_associated :${attr}\n" "validates_associated : ..." nil
			("ActiveRecord")
			nil "~/dot.emacs/snippets/ruby-mode/va" nil nil)
		       ("usau" "unless ARGV.$1\n  abort \"Usage:  #{\\$PROGRAM_NAME} ${2:ARGS_GO_HERE}\"\nend" "usau" nil nil nil "~/dot.emacs/snippets/ruby-mode/usau" nil nil)
		       ("usai" "if ARGV.$1\n  abort \"Usage:  #{\\$PROGRAM_NAME} ${2:ARGS_GO_HERE}\"\nend" "usai" nil nil nil "~/dot.emacs/snippets/ruby-mode/usai" nil nil)
		       ("upt" "upto(${1:1.0/0.0}) { |${2:n}| $0 }" "upto(1.0/0.0) { |n| .. }" nil nil nil "~/dot.emacs/snippets/ruby-mode/upt" nil nil)
		       ("until" "until ${1:condition}\n  $0\nend" "until ... end" nil nil nil "~/dot.emacs/snippets/ruby-mode/until" nil nil)
		       ("unless" "unless ${1:condition}\n  $0\nend" "unless ... end" nil
			("Conditions")
			nil "~/dot.emacs/snippets/ruby-mode/unless" nil nil)
		       ("unif" "ARGF.each_line$1 do |${2:line}|\n  $0\nend" "unix_filter { .. }" nil nil nil "~/dot.emacs/snippets/ruby-mode/unif" nil nil)
		       ("ts" "require \"test/unit\"\n\nrequire \"tc_${1:test_case_file}\"\nrequire \"tc_${2:test_case_file}\"\n" "ts" nil nil nil "~/dot.emacs/snippets/ruby-mode/ts" nil nil)
		       ("tra" "transaction${1/(^.*?\\S.*)|.*/(?1:\\()/}${1:true}${1/(^.*?\\S.*)|.*/(?1:\\))/} { $0 }" "tra" nil nil nil "~/dot.emacs/snippets/ruby-mode/tra" nil nil)
		       ("tim" "times { |${n}| $0 }" "times { |n| ... }" nil nil nil "~/dot.emacs/snippets/ruby-mode/tim" nil nil)
		       ("tc" "require \"test/unit\"\n\nrequire \"${1:library_file_name}\"\n\nclass Test${2:${1/([\\w&&[^_]]+)|./\\u$1/g}} < Test::Unit::TestCase\n  def test_${3:case_name}\n    $0\n  end\nend" "tc" nil nil nil "~/dot.emacs/snippets/ruby-mode/tc" nil nil)
		       ("task.1" "desc \"${1:Task description}\"\ntask :${2:name} do\n  $0\nend" "desc ... task :name ... end" nil nil nil "~/dot.emacs/snippets/ruby-mode/task.1" nil nil)
		       ("task" "task :${2:name} do\n  $0\nend" "task :name ... end" nil nil nil "~/dot.emacs/snippets/ruby-mode/task" nil nil)
		       ("sub" "sub(/${pattern}/) { |${match}| $0 }" "sub(/../) { |match| .. }" nil nil nil "~/dot.emacs/snippets/ruby-mode/sub" nil nil)
		       ("ste" "step(${1:2}) { |${2:n}| $0 }" "step(2) { |e| .. }" nil nil nil "~/dot.emacs/snippets/ruby-mode/ste" nil nil)
		       ("sr" "should_receive(:${1:method}).and_return(${2:return_val})" "should_receive(:).and_return()" nil nil nil "~/dot.emacs/snippets/ruby-mode/sr" nil nil)
		       ("sorb" "sort_by { |${e}| $0 }" "sort_by { |e| .. }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/sorb" nil nil)
		       ("sor" "sort { |a, b| $0 }" "sort { |a, b| .. }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/sor" nil nil)
		       ("sinc" "class << self; self end" "singleton_class()" nil nil nil "~/dot.emacs/snippets/ruby-mode/sinc" nil nil)
		       ("ses" "session[:${user}]\n" "session[: ... ]" nil
			("Rails")
			nil "~/dot.emacs/snippets/ruby-mode/ses" nil nil)
		       ("select" "select { |${1:element}| $0 }" "select { |...| ... }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/select" nil nil)
		       ("sel" "select { |${e}| $0 }" "select { |e| .. }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/sel" nil nil)
		       ("sca" "scan(/${1:pattern}/) { |${2:match}| $0 }" "scan(/../) { |match| .. }" nil nil nil "~/dot.emacs/snippets/ruby-mode/sca" nil nil)
		       ("rw" "attr_accessor :" "attr_accessor ..." nil nil nil "~/dot.emacs/snippets/ruby-mode/rw" nil nil)
		       ("rts" "render :text => \"${Text here...}\", :status => ${401}\n" "render :text => \" ... \", :status =>  ..." nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rts" nil nil)
		       ("rtlt" "render :text => \"${Text here...}\", :layout => ${true}\n" "render :text => \" ... \", :layout =>  ..." nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rtlt" nil nil)
		       ("rtl" "render :text => \"${Text here...}\", :layout => \"${layoutname}\"\n" "render :text => \" ... \", :layout => \" ... \"" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rtl" nil nil)
		       ("rt" "render :text => \"${Text here...}\"\n" "render :text => \" ... \"" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rt" nil nil)
		       ("rreq" "require File.join(File.dirname(__FILE__), $0)" "require File.join(File.dirname(__FILE__), ...)" nil nil nil "~/dot.emacs/snippets/ruby-mode/rreq" nil nil)
		       ("rps" "render :partial => \"${item}\", :status => ${500}\n" "render :partial => \" ... \", :status =>  ..." nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rps" nil nil)
		       ("rpo" "render :partial => \"${item}\", :object => ${object}\n" "render :partial => \" ... \", :object =>  ..." nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rpo" nil nil)
		       ("rpl" "render :partial => \"${item}\", :locals => { :${name} => \"${value}\"}\n" "render :partial => \" ... \", :locals => { : ...  => \" ... \"}" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rpl" nil nil)
		       ("rpc" "render :partial => \"${item}\", :collection => ${items}\n" "render :partial => \" ... \", :collection =>  ..." nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rpc" nil nil)
		       ("rp" "render :partial => \"${item}\"\n" "render :partial => \" ... \"" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rp" nil nil)
		       ("rns" "render :nothing => ${true}, :status => ${401}\n" "render :nothing =>  ... , :status =>  ..." nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rns" nil nil)
		       ("rn" "render :nothing => ${true}\n" "render :nothing =>  ..." nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rn" nil nil)
		       ("rl" "render :layout => \"${layoutname}\"\n" "render :layout => \" ... \"" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rl" nil nil)
		       ("rit" "render :inline => \"${<%= 'hello' %>}\", :type => :${rxml})\n" "render :inline => \" ... \", :type => : ... )" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rit" nil nil)
		       ("ril" "render :inline => \"${<%= 'hello' %>}\", :locals => { ${name} => \"${value}\" }\n" "render :inline => \" ... \", :locals => {  ...  => \" ... \" }" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/ril" nil nil)
		       ("ri" "render :inline => \"${<%= 'hello' %>}\"\n" "render :inline => \" ... \"" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/ri" nil nil)
		       ("rfu" "render :file => \"${filepath}\", :use_full_path => ${false}\n" "render :file => \" ... \", :use_full_path =>  ..." nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rfu" nil nil)
		       ("rf" "render :file => \"${filepath}\"\n" "render :file => \" ... \"" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rf" nil nil)
		       ("reve" "reverse_each { |${1:e}| $0 }" "reve" nil nil nil "~/dot.emacs/snippets/ruby-mode/reve" nil nil)
		       ("res" "respond_to do |format|\n  format.${1:html} $0\nend\n" "respond_to do |format| .." nil
			("ActionController")
			nil "~/dot.emacs/snippets/ruby-mode/res" nil nil)
		       ("req" "require \"$0\"" "require \"...\"" nil nil nil "~/dot.emacs/snippets/ruby-mode/req" nil nil)
		       ("rep" "results.report(\"${1:name}:\") { TESTS.times { $0 } }" "results_report(..) { .. }" nil nil nil "~/dot.emacs/snippets/ruby-mode/rep" nil nil)
		       ("reject" "reject { |${1:element}| $0 }" "reject { |...| ... }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/reject" nil nil)
		       ("rej" "reject { |${1:e}| $0 }" "reject { |e| .. }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/rej" nil nil)
		       ("recai" "redirect_to :controller => \"${items}\", :action => \"${show}\", :id => ${@item}\n" "redirect_to :controller => \" ... \", :action => \" ... \", :id =>  ..." nil
			("Rails redirect")
			nil "~/dot.emacs/snippets/ruby-mode/recai" nil nil)
		       ("reca" "redirect_to :controller => \"${items}\", :action => \"${list}\"\n" "redirect_to :controller => \" ... \", :action => \" ... \"" nil
			("Rails redirect")
			nil "~/dot.emacs/snippets/ruby-mode/reca" nil nil)
		       ("rec" "redirect_to :controller => \"${items}\"\n" "redirect_to :controller => \" ... \"" nil
			("Rails redirect")
			nil "~/dot.emacs/snippets/ruby-mode/rec" nil nil)
		       ("reai" "redirect_to :action => \"${show}\", :id => ${@item}\n" "redirect_to :action => \" ... \", :id =>  ..." nil
			("Rails redirect")
			nil "~/dot.emacs/snippets/ruby-mode/reai" nil nil)
		       ("rea" "redirect_to :action => \"${index}\"\n" "redirect_to :action => \" ... \"" nil
			("Rails redirect")
			nil "~/dot.emacs/snippets/ruby-mode/rea" nil nil)
		       ("rceca" "render_component :controller => \"${items}\", :action => \"${index}\"\n" "render_component :controller => \" ... \", :action => \" ... \"" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rceca" nil nil)
		       ("rcec" "render_component :controller => \"${items}\"\n" "render_component :controller => \" ... \"" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rcec" nil nil)
		       ("rcea" "render_component :action => \"${index}\"\n" "render_component :action => \" ... \"" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/rcea" nil nil)
		       ("rb" "#!/usr/bin/ruby -wKU\n" "/usr/bin/ruby -wKU" nil
			("general")
			nil "~/dot.emacs/snippets/ruby-mode/rb" nil nil)
		       ("ran" "sort_by { rand }" "ran" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/ran" nil nil)
		       ("ral" "render :action => \"${action}\", :layout => \"${layoutname}\"\n" "render :action => \" ... \", :layout => \" ... \"" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/ral" nil nil)
		       ("ra" "render :action => \"${action}\"\n" "render :action => \" ... \"" nil
			("Rails render")
			nil "~/dot.emacs/snippets/ruby-mode/ra" nil nil)
		       ("r" "attr_reader :" "attr_reader ..." nil nil nil "~/dot.emacs/snippets/ruby-mode/r" nil nil)
		       ("pend" "__END__\n" "program end" nil nil nil "~/dot.emacs/snippets/ruby-mode/pend" nil nil)
		       ("patfh" "File.join(File.dirname(__FILE__), *%w[${1:rel path here}])" "patfh" nil nil nil "~/dot.emacs/snippets/ruby-mode/patfh" nil nil)
		       ("par" "params[:${id}]\n" "params[: ... ]" nil
			("Rails")
			nil "~/dot.emacs/snippets/ruby-mode/par" nil nil)
		       ("optp" "require \"optparse\"\n\noptions = {${1::default => \"args\"}}\n\nARGV.options do |opts|\n  opts.banner = \"Usage:  #{File.basename(\\$PROGRAM_NAME)} [OPTIONS]${2/^\\s*$|(.*\\S.*)/(?1: )/}${2:OTHER_ARGS}\"\n  \n  opts.separator \"\"\n  opts.separator \"Specific Options:\"\n  \n  $0\n  \n  opts.separator \"Common Options:\"\n  \n  opts.on( \"-h\", \"--help\",\n           \"Show this message.\" ) do\n    puts opts\n    exit\n  end\n  \n  begin\n    opts.parse!\n  rescue\n    puts opts\n    exit\n  end\nend\n" "optp" nil nil nil "~/dot.emacs/snippets/ruby-mode/optp" nil nil)
		       ("opt" "opts.on( \"-${1:o}\", \"--${2:long-option-name}\"${3/^\\s*$|(.*\\S.*)/(?1:, )/}${3:String},\n         \"${4:Option description.}\" ) do |${6:opt}|\n  $0\nend" "opt" nil nil nil "~/dot.emacs/snippets/ruby-mode/opt" nil nil)
		       ("ope" "open(${1:\"${2:path/or/url/or/pipe}\"}${3/(^[rwab+]+$)|.*/(?1:, \")/}${3:w}${3/(^[rwab+]+$)|.*/(?1:\")/}) { |${4:io}| $0 }" "ope" nil nil nil "~/dot.emacs/snippets/ruby-mode/ope" nil nil)
		       ("nam" "namespace :${1:${TM_FILENAME/\\.\\w+//}} do\n  $0\nend" "nam" nil nil nil "~/dot.emacs/snippets/ruby-mode/nam" nil nil)
		       ("module" "module ${ModuleName}\n  $0\nend\n" "module ModuleName ... end" nil nil nil "~/dot.emacs/snippets/ruby-mode/module" nil nil)
		       ("mod.1" "module ${1:ModuleName}\n  module ClassMethods\n    $0\n  end\n  \n  module InstanceMethods\n    \n  end\n  \n  def self.included(receiver)\n    receiver.extend         ClassMethods\n    receiver.send :include, InstanceMethods\n  end\nend\n" "mod.1" nil nil nil "~/dot.emacs/snippets/ruby-mode/mod.1" nil nil)
		       ("mod" "module ${ModuleName}\n  $0\nend\n" "module ModuleName ... end" nil nil nil "~/dot.emacs/snippets/ruby-mode/mod" nil nil)
		       ("mm" "def method_missing(method, *args)\n  $0\nend" "def method_missing ... end" nil nil nil "~/dot.emacs/snippets/ruby-mode/mm" nil nil)
		       ("min" "min { |a, b| $0 }" "min" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/min" nil nil)
		       ("max" "max { |a, b| $0 }" "max" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/max" nil nil)
		       ("mapwi-" "enum_with_index.map { |${1:e}, ${2:i}| $0 }" "mapwi-" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/mapwi-" nil nil)
		       ("map" "map { |${1:e}| $0 }" "map" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/map" nil nil)
		       ("loo" "loop { $0 }" "loop { .. }" nil
			("Loops")
			nil "~/dot.emacs/snippets/ruby-mode/loo" nil nil)
		       ("logi" "logger.info \"${Text here...}\"\n" "logger.info \" ... \"" nil
			("general")
			nil "~/dot.emacs/snippets/ruby-mode/logi" nil nil)
		       ("lam" "lambda { ${1/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${1:args}${1/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }" "lam" nil nil nil "~/dot.emacs/snippets/ruby-mode/lam" nil nil)
		       ("inject" "inject(${1:0}) { |${2:injection}, ${3:element}| $0 }" "inject(...) { |...| ... }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/inject" nil nil)
		       ("inj" "inject${1/.+/(/}${1:init}${1/.+/)/} { |${2:mem}, ${3:var}| $0 }" "inj" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/inj" nil nil)
		       ("ife" "if ${1:condition}\n  $2\nelse\n  $3\nend" "if ... else ... end" nil
			("Conditions")
			nil "~/dot.emacs/snippets/ruby-mode/ife" nil nil)
		       ("if" "if ${1:condition}\n  $0\nend" "if ... end" nil
			("Conditions")
			nil "~/dot.emacs/snippets/ruby-mode/if" nil nil)
		       ("i" "def initialize(${1:params})\n  ${2:body}\nend\n$0" "def initialize(...) ... end" nil nil nil "~/dot.emacs/snippets/ruby-mode/i" nil nil)
		       ("ho" "has_one :${class}\n" "has_one : ..." nil
			("ActiveRecord")
			nil "~/dot.emacs/snippets/ruby-mode/ho" nil nil)
		       ("hm" "has_many :${class}\n" "has_many : ..." nil
			("ActiveRecord")
			nil "~/dot.emacs/snippets/ruby-mode/hm" nil nil)
		       ("gsu" "gsub(/${1:pattern}/) { ${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${2:match}${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }" "gsu" nil nil nil "~/dot.emacs/snippets/ruby-mode/gsu" nil nil)
		       ("gre" "grep(${1:/${2:pattern}/}) { |${3:match}| $0 }" "gre" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/gre" nil nil)
		       ("forin" "for ${1:element} in ${2:collection}\n  $0\nend" "for ... in ...; ... end" nil
			("Loops")
			nil "~/dot.emacs/snippets/ruby-mode/forin" nil nil)
		       ("flsh" "flash[:${notice}] = \"${Text here...}\"\n" "flash[: ... ] = \" ... \"" nil
			("Rails")
			nil "~/dot.emacs/snippets/ruby-mode/flsh" nil nil)
		       ("flao" "inject(Array.new) { |${1:arr}, ${2:a}| ${1:arr}.push(*${2:a}) }" "flao" nil
			("Arrays")
			nil "~/dot.emacs/snippets/ruby-mode/flao" nil nil)
		       ("fl" "flunk`snippet_paren.rb`\"${0:Failure message.}\"`snippet_paren.rb end`" "fl" nil nil nil "~/dot.emacs/snippets/ruby-mode/fl" nil nil)
		       ("fina" "find_all { |${1:e}| $0 }" "fina" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/fina" nil nil)
		       ("fin" "find { |${1:e}| $0 }" "find { |e| .. }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/fin" nil nil)
		       ("filedn" "File.dirname(${1:__FILE__}) + \"/$0\"" "File.dirname(__FILE__)" nil
			("Files")
			nil "~/dot.emacs/snippets/ruby-mode/filedn" nil nil)
		       ("fil" "fill(${1:range}) { ${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${2:i}${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }" "fil" nil nil nil "~/dot.emacs/snippets/ruby-mode/fil" nil nil)
		       ("fet" "fetch(${1:name}) { ${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${2:key}${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }" "fet" nil nil nil "~/dot.emacs/snippets/ruby-mode/fet" nil nil)
		       ("eawi" "each_with_index { |${e}, ${i}| $0 }" "each_with_index { |e, i| ... }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/eawi" nil nil)
		       ("eav" "each_value { |${val}| $0 }" "each_value { |val| ... }" nil nil nil "~/dot.emacs/snippets/ruby-mode/eav" nil nil)
		       ("eas-" "each_slice(${1:2}) { |${2:group}| $0 }" "eas-" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/eas-" nil nil)
		       ("eap" "each_pair { |${1:name}, ${2:val}| $0 }" "eap" nil nil nil "~/dot.emacs/snippets/ruby-mode/eap" nil nil)
		       ("eal" "each_line$1 { |${2:line}| $0 }" "eal" nil nil nil "~/dot.emacs/snippets/ruby-mode/eal" nil nil)
		       ("eak" "each_key { |${1:key}| $0 }" "eak" nil nil nil "~/dot.emacs/snippets/ruby-mode/eak" nil nil)
		       ("eai" "each_index { |${i}| $0 }" "each_index { |i| ... }" nil nil nil "~/dot.emacs/snippets/ruby-mode/eai" nil nil)
		       ("eac-" "each_char { |${1:chr}| $0 }" "eac-" nil nil nil "~/dot.emacs/snippets/ruby-mode/eac-" nil nil)
		       ("eac" "each_cons(${1:2}) { |${group}| $0 }" "each_cons(...) { |...| ... }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/eac" nil nil)
		       ("eab" "each_byte { |${1:byte}| $0 }" "eab" nil nil nil "~/dot.emacs/snippets/ruby-mode/eab" nil nil)
		       ("ea" "each { |${e}| $0 }" "each { |...| ... }" nil nil nil "~/dot.emacs/snippets/ruby-mode/ea" nil nil)
		       ("dow" "downto(${1:0}) { ${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}${2:n}${2/(^(?<var>\\s*(?:\\*|\\*?[a-z_])[a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}$0 }" "dow" nil
			("Loops")
			nil "~/dot.emacs/snippets/ruby-mode/dow" nil nil)
		       ("do" "do |${1:variable}|\n  $0\nend" "do |variable| ... end" nil
			("Blocks")
			nil "~/dot.emacs/snippets/ruby-mode/do" nil nil)
		       ("det" "detect { |${e}| $0 }" "detect { |...| ... }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/det" nil nil)
		       ("desc" "describe \"${1:method}\" do\n  it$0\nend" "describe (rspec)" nil nil nil "~/dot.emacs/snippets/ruby-mode/desc" nil nil)
		       ("deli" "delete_if { |${e} $0 }" "delete_if { |...| ... }" nil nil nil "~/dot.emacs/snippets/ruby-mode/deli" nil nil)
		       ("deft" "def test_${1:case_name}\n  $0\nend" "deft" nil nil nil "~/dot.emacs/snippets/ruby-mode/deft" nil nil)
		       ("defs" "def self.${1:class_method_name}\n  $0\nend" "def.self ... end" nil nil nil "~/dot.emacs/snippets/ruby-mode/defs" nil nil)
		       ("defmm" "def method_missing(meth, *args, &blk)\n  $0\nend" "defmm" nil nil nil "~/dot.emacs/snippets/ruby-mode/defmm" nil nil)
		       ("defds" "def_delegators :${1:@del_obj}, :${0:del_methods}" "defds" nil nil nil "~/dot.emacs/snippets/ruby-mode/defds" nil nil)
		       ("defd" "def_delegator :${1:@del_obj}, :${2:del_meth}, :${3:new_name}" "defd" nil nil nil "~/dot.emacs/snippets/ruby-mode/defd" nil nil)
		       ("def" "def ${1:method_name}\n  $0\nend" "def ... end" nil
			("definitions")
			nil "~/dot.emacs/snippets/ruby-mode/def" nil nil)
		       ("deec" "Marshal.load(Marshal.dump(${0:obj_to_copy}))" "deec" nil nil nil "~/dot.emacs/snippets/ruby-mode/deec" nil nil)
		       ("dee" "Marshal.load(Marshal.dump($0))" "deep_copy(...)" nil nil nil "~/dot.emacs/snippets/ruby-mode/dee" nil nil)
		       ("collect" "collect { |${e}| $0 }" "collect { |...| ... }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/collect" nil nil)
		       ("col" "collect { |${e}| $0 }\n" "collect { |e| ... }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/col" nil nil)
		       ("cls" "class ${1:`(let ((fn (capitalize (file-name-nondirectory\n                                 (file-name-sans-extension\n         (or (buffer-file-name)\n             (buffer-name (current-buffer))))))))\n           (cond\n             ((string-match \"_\" fn) (replace-match \"\" nil nil fn))\n              (t fn)))`}\n  $0\nend\n" "class ... end" nil nil nil "~/dot.emacs/snippets/ruby-mode/cls" nil nil)
		       ("classify" "classify { |${e}| $0 }" "classify { |...| ... }" nil
			("collections")
			nil "~/dot.emacs/snippets/ruby-mode/classify" nil nil)
		       ("clafn" "split(\"::\").inject(Object) { |par, const| par.const_get(const) }" "class_from_name()" nil nil nil "~/dot.emacs/snippets/ruby-mode/clafn" nil nil)
		       ("cla.4" "class ${1:BlankSlate}\n  instance_methods.each { |meth| undef_method(meth) unless meth =~ /\\A__/ }\n  \n  def initialize${2/(^.*?\\S.*)|.*/(?1:\\()/}${2:args}${2/(^.*?\\S.*)|.*/(?1:\\))/}\n    @${3:delegate} = ${4:delegate_object}\n    \n    $0\n  end\n  \n  def method_missing(meth, *args, &block)\n    @${3:delegate}.send(meth, *args, &block)\n  end\n  \n  \nend" "cla.4" nil
			("definitions")
			nil "~/dot.emacs/snippets/ruby-mode/cla.4" nil nil)
		       ("cla.3" "class ${1:${TM_FILENAME/(?:\\A|_)([A-Za-z0-9]+)(?:\\.rb)?/(?2::\\u$1)/g}}\n  def initialize${2/(^.*?\\S.*)|.*/(?1:\\()/}${2:args}${2/(^.*?\\S.*)|.*/(?1:\\))/}\n    $0\n  end\n  \n  \nend" "cla.3" nil
			("definitions")
			nil "~/dot.emacs/snippets/ruby-mode/cla.3" nil nil)
		       ("cla.2" "class ${1:${TM_FILENAME/(?:\\A|_)([A-Za-z0-9]+)(?:\\.rb)?/(?2::\\u$1)/g}}\n  $0\nend" "cla.2" nil
			("definitions")
			nil "~/dot.emacs/snippets/ruby-mode/cla.2" nil nil)
		       ("cla.1" "${1:${TM_FILENAME/(?:\\A|_)([A-Za-z0-9]+)(?:\\.rb)?/(?2::\\u$1)/g}} = Struct.new(:${2:attr_names}) do\n  def ${3:method_name}\n    $0\n  end\n  \n  \nend" "cla.1" nil
			("definitions")
			nil "~/dot.emacs/snippets/ruby-mode/cla.1" nil nil)
		       ("cla-" "class ${1:ClassName} < DelegateClass(${2:ParentClass})\n  def initialize(${3:args})\n    super(${4:del_obj})\n    \n    $0\n  end\n  \n  \nend" "class .. < DelegateClass .. initialize .. end  (class)" nil
			("definitions")
			nil "~/dot.emacs/snippets/ruby-mode/cla-" nil nil)
		       ("cla" "class << ${self}\n  $0\nend" "class << self ... end" nil
			("definitions")
			nil "~/dot.emacs/snippets/ruby-mode/cla" nil nil)
		       ("cl" "classify { |${e}| $0 }" "classify { |...| ... }" nil nil nil "~/dot.emacs/snippets/ruby-mode/cl" nil nil)
		       ("case" "case ${1:object}\nwhen ${2:condition}\n  $0\nend" "case ... end" nil
			("Conditions")
			nil "~/dot.emacs/snippets/ruby-mode/case" nil nil)
		       ("bt" "belongs_to :${class}\n" "belongs_to : ..." nil
			("ActiveRecord")
			nil "~/dot.emacs/snippets/ruby-mode/bt" nil nil)
		       ("bm-" "TESTS = ${1:10_000}\nBenchmark.bmbm do |results|\n  $0\nend" "bm-" nil nil nil "~/dot.emacs/snippets/ruby-mode/bm-" nil nil)
		       ("bm" "Benchmark.bmbm(${1:10}) do |x|\n  $0\nend" "Benchmark.bmbm(...) do ... end" nil nil nil "~/dot.emacs/snippets/ruby-mode/bm" nil nil)
		       ("begin" "begin\n  $3\nrescue ${1:Exception} => ${2:e}\n  $0\nend" "begin ... rescue ... end" nil
			("Blocks")
			nil "~/dot.emacs/snippets/ruby-mode/begin" nil nil)
		       ("ast" "assert_throws(:${1:expected}) { $0 }" "ast" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/ast" nil nil)
		       ("ass.1" "assert_send`snippet_paren.rb`[${1:object}, :${2:message}, ${0:args}]`snippet_paren.rb end`" "ass.1" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/ass.1" nil nil)
		       ("ass" "assert_same`snippet_paren.rb`${1:expected}, ${0:actual}`snippet_paren.rb end`" "ass" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/ass" nil nil)
		       ("asrt" "assert_respond_to`snippet_paren.rb`${1:object}, :${0:method}`snippet_paren.rb end`" "asrt" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asrt" nil nil)
		       ("asr" "assert_raise(${1:Exception}) { $0 }" "asr" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asr" nil nil)
		       ("aso" "assert_operator`snippet_paren.rb`${1:left}, :${2:operator}, ${0:right}`snippet_paren.rb end`" "aso" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/aso" nil nil)
		       ("asnt" "assert_nothing_thrown { $0 }" "asnt" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asnt" nil nil)
		       ("asns" "assert_not_same`snippet_paren.rb`${1:unexpected}, ${0:actual}`snippet_paren.rb end`" "asns" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asns" nil nil)
		       ("asnr" "assert_nothing_raised(${1:Exception}) { $0 }" "asnr" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asnr" nil nil)
		       ("asnn" "assert_not_nil`snippet_paren.rb`${0:instance}`snippet_paren.rb end`" "asnn" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asnn" nil nil)
		       ("asnm" "assert_no_match`snippet_paren.rb`/${1:unexpected_pattern}/, ${0:actual_string}`snippet_paren.rb end`" "asnm" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asnm" nil nil)
		       ("asne" "assert_not_equal`snippet_paren.rb`${1:unexpected}, ${0:actual}`snippet_paren.rb end`" "asne" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asne" nil nil)
		       ("asn" "assert_nil`snippet_paren.rb`${0:instance}`snippet_paren.rb end`" "asn" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asn" nil nil)
		       ("asm" "assert_match`snippet_paren.rb`/${1:expected_pattern}/, ${0:actual_string}`snippet_paren.rb end`" "asm" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asm" nil nil)
		       ("asko" "assert_kind_of`snippet_paren.rb`${1:ExpectedKind}, ${0:actual_instance}`snippet_paren.rb end`" "asko" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asko" nil nil)
		       ("asio" "assert_instance_of`snippet_paren.rb`${1:ExpectedClass}, ${0:actual_instance}`snippet_paren.rb end`" "asio" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asio" nil nil)
		       ("asid" "assert_in_delta`snippet_paren.rb`${1:expected_float}, ${2:actual_float}, ${0:2 ** -20}`snippet_paren.rb end`" "asid" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/asid" nil nil)
		       ("ase" "assert_equal`snippet_paren.rb`${1:expected}, ${0:actual}`snippet_paren.rb end`" "ase" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/ase" nil nil)
		       ("as" "assert`snippet_paren.rb`${1:test}, \"${0:Failure message.}\"`snippet_paren.rb end`" "as" nil
			("Tests")
			nil "~/dot.emacs/snippets/ruby-mode/as" nil nil)
		       ("art" "assert_redirected_to :controller => \"${controller}\"\n" "assert_redirected_to :controller => \" ... \"" nil
			("assert")
			nil "~/dot.emacs/snippets/ruby-mode/art" nil nil)
		       ("ars" "assert_response :${success}\n" "assert_response : ..." nil
			("assert")
			nil "~/dot.emacs/snippets/ruby-mode/ars" nil nil)
		       ("ar" "attr_reader :$0" "attr_reader :..." nil nil nil "~/dot.emacs/snippets/ruby-mode/ar" nil nil)
		       ("app" "if __FILE__ == $PROGRAM_NAME\n  $0\nend" "if __FILE__ == $PROGRAM_NAME ... end" nil nil nil "~/dot.emacs/snippets/ruby-mode/app" nil nil)
		       ("any" "any? { |${e}| $0 }" "any? { |...| ... }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/any" nil nil)
		       ("ann" "assert_not_nil ${object}\n" "assert_not_nil  ..." nil
			("assert")
			nil "~/dot.emacs/snippets/ruby-mode/ann" nil nil)
		       ("am" "alias_method :${new_name}, :${old_name}" "alias_method new, old" nil nil nil "~/dot.emacs/snippets/ruby-mode/am" nil nil)
		       ("all" "all? { |${e}| $0 }" "all? { |...| ... }" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/all" nil nil)
		       ("ako" "assert_kind_of ${class}, ${object}\n" "assert_kind_of  ... ,  ..." nil
			("assert")
			nil "~/dot.emacs/snippets/ruby-mode/ako" nil nil)
		       ("ae" "assert_equal ${expected}, ${actual}\n" "assert_equal  ... ,  ..." nil
			("assert")
			nil "~/dot.emacs/snippets/ruby-mode/ae" nil nil)
		       ("aa" "attr_accessor :$0" "attr_accesor :..." nil nil nil "~/dot.emacs/snippets/ruby-mode/aa" nil nil)
		       ("Yl-" "File.open(\"${1:path/to/file.yaml}\") { |${2:file}| YAML.load(${2:file}) }" "YAML.load(file)" nil nil nil "~/dot.emacs/snippets/ruby-mode/Yl-" nil nil)
		       ("Yd-" "File.open(${1:\"${2:path/to/file}.yaml\"}, \"w\") { |${3:file}| YAML.dump(${4:obj}, ${3:file}) }" "Yd-" nil nil nil "~/dot.emacs/snippets/ruby-mode/Yd-" nil nil)
		       ("README.markdown" "# Snippets for Ruby Mode\n\n## About\n\nComprehensive collection of Ruby snippets for\n[yasnippet](http://code.google.com/p/yasnippet/ \"yasnippet - Google Code\").\nThe collection also contains snippets for major Ruby frameworks like Rails\nand RSpec.\n\nThe Rails snippets were originally borrowed from\n[mknittig/yasnippet-rails](http://github.com/eschulte/yasnippets-rails/tree/master).\n\nThe RSpec snippets require that RSpec files are edited in a separate\nEmacs mode. I recommend using\n[rspec-mode](http://github.com/pezra/rspec-mode/tree/master).\nThe RSpec snippets were originally borrowed from\n[gary/yasnippets-rspec](http://github.com/gary/yasnippets-rspec/tree/master).\n\n## Contributors\n\nSee https://github.com/bmaland/yasnippet-ruby-mode/contributors\n\nMuch of the credits should naturally go to the yasnippet-rails and\nyasnippet-rspec authors.\n\nThanks to Jeff Wheeler for his work on the snippet_copier.py script!\n" "README.markdown" nil nil nil "~/dot.emacs/snippets/ruby-mode/README.markdown" nil nil)
		       ("Pn-" "PStore.new(${1:\"${2:file_name.pstore}\"})" "Pn-" nil nil nil "~/dot.emacs/snippets/ruby-mode/Pn-" nil nil)
		       ("Ml" "File.open(${1:\"${2:path/to/file}.dump\"}) { |${3:file}| Marshal.load(${3:file}) }" "Ml" nil nil nil "~/dot.emacs/snippets/ruby-mode/Ml" nil nil)
		       ("Md" "File.open(${1:\"${2:path/to/file}.dump\"}, \"w\") { |${3:file}| Marshal.dump(${4:obj}, ${3:file}) }" "Md" nil nil nil "~/dot.emacs/snippets/ruby-mode/Md" nil nil)
		       ("Hash" "Hash.new { |${1:hash}, ${2:key}| ${1:hash}[${2:key}] = $0 }" "Hash" nil
			("Hashes")
			nil "~/dot.emacs/snippets/ruby-mode/Hash" nil nil)
		       ("Forw-" "extend Forwardable" "Forw-" nil nil nil "~/dot.emacs/snippets/ruby-mode/Forw-" nil nil)
		       ("File.2" "File.read(${1:\"${2:path/to/file}\"})" "File.2" nil
			("Files")
			nil "~/dot.emacs/snippets/ruby-mode/File.2" nil nil)
		       ("File.1" "File.open(${1:\"${2:path/to/file}\"}${3/(^[rwab+]+$)|.*/(?1:, \")/}${3:w}${3/(^[rwab+]+$)|.*/(?1:\")/}) { |${4:file}| $0 }" "File.1" nil
			("Files")
			nil "~/dot.emacs/snippets/ruby-mode/File.1" nil nil)
		       ("File" "File.foreach(${1:\"${2:path/to/file}\"}) { |${3:line}| $0 }" "File" nil
			("Files")
			nil "~/dot.emacs/snippets/ruby-mode/File" nil nil)
		       ("Enum" "include Enumerable\n\ndef each(&block)\n  $0\nend" "Enum" nil
			("Enumerables")
			nil "~/dot.emacs/snippets/ruby-mode/Enum" nil nil)
		       ("Dir" "Dir.glob(${1:\"dir/glob/*}\") { |${2:file}| $0 }" "Dir.glob(\"..\") do |file| .. end" nil
			("Files")
			nil "~/dot.emacs/snippets/ruby-mode/Dir" nil nil)
		       ("Comp" "include Comparable\n\ndef <=> other\n  $0\nend" "include Comparable; def <=> ... end" nil nil nil "~/dot.emacs/snippets/ruby-mode/Comp" nil nil)
		       ("Array" "Array.new(${10}) { |${i}| $0 }" "Array.new(10) { |i| ... }" nil
			("Arrays")
			nil "~/dot.emacs/snippets/ruby-mode/Array" nil nil)
		       ("=b" "=begin rdoc\n  $0\n=end" "=b" nil nil nil "~/dot.emacs/snippets/ruby-mode/=b" nil nil)
		       (":" ":${key} => ${\"value\"}" ":key => \"value\"" nil nil nil "~/dot.emacs/snippets/ruby-mode/:" nil nil)
		       ("#" "# => " "# =>" nil nil nil "~/dot.emacs/snippets/ruby-mode/#" nil nil)
		       ("!env" "#!/usr/bin/env ruby\n" "/usr/bin/env ruby" nil nil nil "~/dot.emacs/snippets/ruby-mode/!env" nil nil)))


;;; Snippet definitions:
;;;
(yas-define-snippets 'ruby-mode
		     '(("wia" "with(${1:args})\n$0" "with args" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/wia" nil nil)
		       ("tw" "twice" "twice" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/tw" nil nil)
		       ("stub" "${1:target}.stub!(:${2:message})$0" "$target.stub!(:$message)" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/stub" nil nil)
		       ("sto" "Story '${1:title}', %{\n  As a ${2:role}\n  I want ${3:feature}\n  So that ${4:value}\n} do\nend" "Story" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/sto" nil nil)
		       ("sht" "lambda { ${1: } }.should throw_symbol(:${2:symbol})\n$0" "should throw" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/sht" nil nil)
		       ("shs" "${1:target}.should satisfy { |obj| ${2: } }\n$0" "should satisfy" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shs" nil nil)
		       ("shrt.respond" "${1:target}.should respond_to(:${2:sym})\n$0" "should respond_to" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shrt.respond" nil nil)
		       ("shrt.render" "response.should render_template(:${1:template})\n$0" "should render_template" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shrt.render" nil nil)
		       ("shrt.redirect" "response.should redirect_to(${1:url})\n$0" "should redirect_to" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shrt.redirect" nil nil)
		       ("shrt" "response.should render_template(\"${0:template}\")" "response.should render_template(\"$template\")" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shrt" nil nil)
		       ("shre" "lambda { ${1: } }.should raise_error(${2:error})\n$0" "should raise_error" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shre" nil nil)
		       ("shr" "${1:mock}.should_receive(:${2:message})$0" "should_receive" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shr" nil nil)
		       ("shp" "${1:target}.should ${2:be_}${3:predicate} $0" "should predicate" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shp" nil nil)
		       ("shnt" "lambda { ${1: } }.should_not throw_symbol(:${2:symbol})\n$0" "should_not throw" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shnt" nil nil)
		       ("shns" "${1:target}.should_not satisfy { |obj| ${2: } }\n$0" "should_not satisfy" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shns" nil nil)
		       ("shnrt" "${1:target}.should_not respond_to(:${2:sym})\n$0" "should_not respond_to" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shnrt" nil nil)
		       ("shnre" "lambda { ${1: } }.should_not raise_error(${2:error})\n$0" "should_not raise_error" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shnre" nil nil)
		       ("shnr" "${1:mock}.should_not_receive(:${2:message})$0" "should_not_receive" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shnr" nil nil)
		       ("shnp" "${1:target}.should_not ${2:be_}${3:predicate} $0" "should_not predicate" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shnp" nil nil)
		       ("shnm.match" "${1:target}.should_not match(/${2:regex}/)\n$0" "should_not match" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shnm.match" nil nil)
		       ("shne.equal" "${1:target}.should_not equal(${2:value})\n$0" "should_not equal" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shne.equal" nil nil)
		       ("shne.eql" "${1:target}.should_not eql(${2:value})\n$0" "should_not eql" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shne.eql" nil nil)
		       ("shnbs" "response.should_not be_success\n$0" "should_not be_success" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shnbs" nil nil)
		       ("shnbr" "response.should_not be_redirect\n$0" "should_not be_redirect" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shnbr" nil nil)
		       ("shnbko" "${1:target}.should_not be_a_kind_of(${2:klass})\n$0" "should_not be_kind_of" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shnbko" nil nil)
		       ("shnbio" "${1:target}.should_not be_instance_of(${2:klass})\n$0" "should_not be_instance_of" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shnbio" nil nil)
		       ("shnbc" "${1:target}.should_not be_close(${2:result}, ${3:tolerance})\n$0" "should_not be_close" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shnbc" nil nil)
		       ("shnb" "${1:target}.should_not be(${2:result})\n$0" "should_not be" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shnb" nil nil)
		       ("shn=" "${1:target}.should_not == ${2:value}\n$0" "should_not ==" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shn=" nil nil)
		       ("shm.match" "${1:target}.should match(/${2:regex}/)\n$0" "should match" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shm.match" nil nil)
		       ("shhr" "${1:target}.should have(${2:x}).records\n$0" "should have_records" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shhr" nil nil)
		       ("shham" "${1:target}.should have_at_most(${2:num}).${3:things}\n$0" "should have_at_most" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shham" nil nil)
		       ("shhal" "${1:target}.should have_at_least(${2:num}).${3:things}\n$0" "should have_at_least" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shhal" nil nil)
		       ("shh" "${1:target}.should have(${2:num}).${3:things}\n$0" "should have" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shh" nil nil)
		       ("she.equal" "${1:target}.should equal(${2:value})\n$0" "should equal" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/she.equal" nil nil)
		       ("she.eql" "${1:target}.should eql(${2:value})\n$0" "should eql" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/she.eql" nil nil)
		       ("shbs" "response.should be_success\n$0" "should be_success" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shbs" nil nil)
		       ("shbr" "response.should be_redirect\n$0" "should be_redirect" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shbr" nil nil)
		       ("shbko" "${1:target}.should be_a_kind_of(${2:klass})\n$0" "should be_kind_of" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shbko" nil nil)
		       ("shbio" "${1:target}.should be_instance_of(${2:klass})\n$0" "should be_instance_of" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shbio" nil nil)
		       ("shbc" "${1:target}.should be_close(${2:result}, ${3:tolerance})\n$0" "should be_close" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shbc" nil nil)
		       ("shb" "${1:target}.should be(${2:result})\n$0" "should be" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/shb" nil nil)
		       ("sh=" "${1:target}.should == ${2:value}\n$0" "should ==" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/sh=" nil nil)
		       ("set" "setup do\n  $1\nend" "setup do ... end" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/set" nil nil)
		       ("sce" "Scenario '${1:title}' do\n  Given '${2:given}'\n  When '${3:when}'\n  Then '${4:then}'\nend\n$0" "Scenario" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/sce" nil nil)
		       ("resh" "require File.dirname(__FILE__) + '/../spec_helper'" "Require spec_helper" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/resh" nil nil)
		       ("on" "once" "once" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/on" nil nil)
		       ("mocw.rr" "Spec::Runner.configure do |config|\n  config.mock_with :rr\nend" "mock_with rr" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/mocw.rr" nil nil)
		       ("mocw.mocha" "Spec::Runner.configure do |config|\n  config.mock_with :mocha\nend" "mock_with mocha" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/mocw.mocha" nil nil)
		       ("mocw.flexmock" "Spec::Runner.configure do |config|\n  config.mock_with :flexmock\nend" "mock_with flexmock" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/mocw.flexmock" nil nil)
		       ("mat" "class ${1:ReverseTo}\n  def initialize($3)\n    @$3 = $3\n  end\n\n  def matches?(actual)\n    @actual = actual\n    # Satisfy expectation here. Return false or raise an error if it's not met.\n    $0@actual.reverse.should == @$3\n    true\n  end\n\n  def failure_message\n    \"expected #{@actual.inspect} to $2 #{@$3.inspect}, but it didn't\"\n  end\n\n  def negative_failure_message\n    \"expected #{@actual.inspect} not to $2 #{@$3.inspect}, but it did\"\n  end\nend\n\ndef ${2:reverse_to}(${3:expected})\n  $1.new($3)\nend" "custom matcher" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/mat" nil nil)
		       ("its" "its(:${1}) { should $0 }" "its" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/its" nil nil)
		       ("it" "it \"should ${1:do something}\" do\n  $0\nend" "it \"should do something\" do ... end" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/it" nil nil)
		       ("fmar" "${1:var} = flexmock(:model, ${2:YourModel})\n$0" "flexmock mock object, ActiveRecord" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/fmar" nil nil)
		       ("fm" "${1:var} = flexmock('${2:mock_name}')\n$0" "flexmock mock object w/name" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/fm" nil nil)
		       ("ex" "exactly(${1:n}).times" "exactly" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/ex" nil nil)
		       ("dests" "describe ${1:Type}, '${2:description}' do\n\n  it 'should ${3:description}' do\n    $0\n  end\n\nend" "describe (type, string)" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/dests" nil nil)
		       ("dest" "describe ${1:Type} do\n\n  it 'should ${2:description}' do\n    $0\n  end\n\nend" "describe (type)" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/dest" nil nil)
		       ("desrc.put" "require File.direname(__FILE__) + '/.../spec_helper'\n\ndescribe ${1:controller}, 'PUT ${3:/some/path}${4: with some parameters}' do\n\n  $0\n\nend" "describe (RESTful Controller): PUT" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/desrc.put" nil nil)
		       ("desrc.post" "require File.direname(__FILE__) + '/.../spec_helper'\n\ndescribe ${1:controller}, 'POST ${3:/some/path}${4: with some parameters}' do\n\n  $0\n\nend" "describe (RESTful Controller): POST" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/desrc.post" nil nil)
		       ("desrc.get" "require File.direname(__FILE__) + '/.../spec_helper'\n\ndescribe ${1:controller}, 'GET ${3:/some/path}${4: with some parameters}' do\n\n  $0\n\nend" "describe (RESTful Controller): GET" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/desrc.get" nil nil)
		       ("desrc.delete" "require File.direname(__FILE__) + '/.../spec_helper'\n\ndescribe ${1:controller}, 'DELETE ${3:/some/path}${4: with some parameters}' do\n\n  $0\n\nend" "describe (RESTful Controller): DELETE" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/desrc.delete" nil nil)
		       ("desc" "require File.dirname(__FILE__) + '/../spec_helper'\n\ndescribe ${1:controller} do\n\n  $0\n\nend" "describe (Controller)" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/desc" nil nil)
		       ("des" "describe '${1:description}' do\n\n  it 'should ${2:description}' do\n    $0\n  end\n\nend" "describe (String)" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/des" nil nil)
		       ("conn" "controller_name :${1:controller}" "controller_name" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/conn" nil nil)
		       ("bfe" "before(:each) do\n  $0\nend" "before(:each) do ... end" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/bfe" nil nil)
		       ("befm" "before(:each) do\n  @${1:model} = ${1:$(replace-regexp-in-string \"_\" \"\" (upcase-initials text))}.new$0\nend\n" "before (rspec)" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/befm" nil nil)
		       ("bef" "before(${1::each}) do\n  $0\nend" "before" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/bef" nil nil)
		       ("atm" "at_most(${1:n}).times" "at_most" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/atm" nil nil)
		       ("atl" "at_least(${1:n}).times" "at_least" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/atl" nil nil)
		       ("any" "any? { |${e}| $0 }" "any? { |...| ... }" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/any" nil nil)
		       ("ant" "and_throw(${1:sym})" "and_throw" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/ant" nil nil)
		       ("anrb" "and_return { $1 }" "and_return with block" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/anrb" nil nil)
		       ("anra" "and_raise(${1:RuntimeError})$0" "and_raise($error)" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/anra" nil nil)
		       ("anr" "and_return(${1:value})$0" "and_return($value)" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/anr" nil nil)
		       ("annot" "any_number_of_times" "any_number_of_times" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/annot" nil nil)
		       ("aft" "after(${1::each}) do\n  $0\nend" "after" nil
			("rspec-mode")
			nil "~/dot.emacs/snippets/ruby-mode/rspec-mode/aft" nil nil)))


;;; Do not edit! File generated at Sun Aug  2 22:36:05 2020
