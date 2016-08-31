class Lita::Session::Configuration

	def method_missing(name, *args, &block)
		return super if [:instance_variable_set, :to_ary, :define_method].include?(name)

		if name[-1] == '='
			name = name[0..-2]
			config = args.flatten.first
		else
			config = Lita::Session::Configuration.new
		end
		self.class.send(:attr_reader, name)
		self.instance_variable_set("@#{name}", config)
  end
end