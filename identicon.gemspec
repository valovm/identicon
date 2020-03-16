Gem::Specification.new do |spec|
  spec.name          = "identicon"
  spec.version       = '0.0.0'
  spec.authors       = ["valovm"]
  spec.email         = ["valov.mikhail.a@gmail.com"]

  spec.summary =    "The simple Identicon gem"
  spec.description = "The simple Identicon gem"
  spec.license       = "MIT"

  spec.require_paths = ["lib"]

  spec.add_dependency        "chunky_png"
  spec.add_development_dependency "rspec", "~> 3.0"
end
