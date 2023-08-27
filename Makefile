DATABASESOURCE=postgres://root:root@localhost:5432/simple_bank?sslmode=disable

postgres:
	docker run --name postgres -e POSTGRES_DB=simple_bank -e POSTGRES_USER=root -e POSTGRES_PASSWORD=root -p 5432:5432 -d postgres:12-alpine
createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_bank
dropdb:
	docker exec -it postgres dropdb simple_bank
migrateup:
	migrate -path db/migration -database $(DATABASESOURCE) up
migratedown:
	migrate -path db/migration -database $(DATABASESOURCE) down
migrateup-next:
	migrate -path db/migration -database $(DATABASESOURCE) up 1
migratedown-previous:
	migrate -path db/migration -database $(DATABASESOURCE) down 1

sqlc:
	sqlc generate
test:
	go test ./...
run:
	go run main.go
mock:
	mockgen -package mockdb -destination db/mock/store.go simplebank.com/db/sqlc Store
.PHONY: postgres createdb dropdb migrateup migratedown sqlc runtest runserver mock