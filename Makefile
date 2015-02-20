# `adocker` is alias to `azk docker`
all:
	# latest
	adocker build -t azukiapp/jruby ./1.7/jre

	# version tagged
	adocker build -t azukiapp/jruby:1.7-jdk ./1.7/jdk

--no-cache:
	# latest
	adocker build --rm --no-cache -t azukiapp/jruby ./1.7/jre

	# version tagged
	adocker build --rm --no-cache -t azukiapp/jruby:1.7-jdk ./1.7/jdk
