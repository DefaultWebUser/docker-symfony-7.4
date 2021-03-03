FROM php:7.4-cli

ARG PHP_TIMEZONE=Asia/Krasnoyarsk

RUN \
	mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" && \
	echo "date.timezone = \"$PHP_TIMEZONE\"\n" >> "$PHP_INI_DIR/conf.d/php-local.ini" && \
	apt-get update && \
	apt-get install -y \
	git unzip wget && \
	#< symfony
	wget https://get.symfony.com/cli/installer -O - | bash && \
	mv /root/.symfony/bin/symfony /usr/local/bin/symfony && \
	#> symfony
	adduser --uid 1000 --gecos '' --disabled-password myuser && \
	apt-get remove -y wget && \
	apt-get autoremove -y && \
	rm -rf /var/lib/apt/lists/*

COPY --from=composer /usr/bin/composer /usr/bin/composer

USER myuser

RUN \
	mkdir /home/myuser/app && \
	git config --global user.email "sym@fo.ny" && \
	git config --global user.name "Symfony"

WORKDIR /home/myuser/app

CMD ["symfony", "server:start", "--no-tls", "--port=8000"]
