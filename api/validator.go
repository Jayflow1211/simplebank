package api

import (
	"github.com/go-playground/validator/v10"
	"simplebank.com/util"
)

var validCurrency validator.Func = func(fieldLevel validator.FieldLevel) bool {
	if v, ok := fieldLevel.Field().Interface().(string); ok {
		return util.ValidCurrency(v)
	}
	return false
}
