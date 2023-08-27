package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
	"simplebank.com/util"
)

var testStore *SQLStore
var db *sql.DB

func TestMain(m *testing.M) {
	config, err := util.LoadConfig("../..")
	if err != nil {
		log.Fatal("cannot load config: ", err)
	}
	db, err = sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatalln("can't connect to db:", err)
	}
	testStore = NewStore(db)
	os.Exit(m.Run())
}
