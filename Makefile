all:
	@mkdir -p /home/engiacom/data/mariadb
	@mkdir -p /home/engiacom/data/wordpress
	docker compose -f docker-compose.yml up --build -d

down:
	docker compose -f docker-compose.yml down -v

re: down all

clean: down
	docker system prune -af

fclean: clean
	rm -rf /home/engiacom/data

.PHONY: all down re clean fclean