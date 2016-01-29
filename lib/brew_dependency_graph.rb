require "brew_dependency_graph/version"

module BrewDependencyGraph
  def self.run()
  	brew_available = `which brew`

		if !brew_available
			puts "Homebrew was not found!"
			return
		end

		Formula = Struct.new(:name)
		Dependency = Struct.new(:package, :dependency)

		puts "Constructing dependency tree..."

		formulas = {}

		brew_packages = `brew list`.split("\n")
		brew_packages.each do |package|
			formulas[package] = []
		end

		for package, dependencies in formulas
			package_dependants = `brew uses --installed #{package}`.split("\n")
			package_dependants.each do |package_dependant|
				dependencies.push(package_dependant)
			end
		end

		puts JSON.pretty_generate(formulas)

  end
end
