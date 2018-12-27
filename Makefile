.DEFAULT_GOAL := help
DOCKERSYNC := $(shell command -v docker-sync-stack 2> /dev/null)

startportainer: ## brings up singleton portainer
	( cd portainer && docker-compose -f singleton.yml --compatibility up -d )

stackstart: ## brings up the whole stack and suite of services
	( cd traefik && docker-compose --compatibility up -d )
	( cd portainer && docker-compose --compatibility up -d )
	( cd mariadb && docker-compose --compatibility up -d )
	( cd adminer && docker-compose --compatibility up -d )
	( cd whoami && docker-compose --compatibility up -d )
	( cd client && docker-compose --compatibility up -d )
	( cd mail && docker-compose --compatibility up -d )

stackstop: ## brings down the whole stack and suite of services
	( cd traefik && docker-compose --compatibility down )
	( cd portainer && docker-compose --compatibility down )
	( cd mariadb && docker-compose --compatibility down )
	( cd adminer && docker-compose --compatibility down )
	( cd whoami && docker-compose --compatibility down )
	( cd client && docker-compose --compatibility down )
	( cd mail && docker-compose --compatibility down )

.PHONY: help

help: ## Helping devs since 2016
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo "For additional commands have a look at the README"


