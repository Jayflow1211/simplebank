package util

const (
	USD = "USD"
	EUR = "EUR"
	CAD = "CAD"
)

func ValidCurrency(currency string) bool {
	switch currency {
	case USD, EUR, CAD:
		return true
	}
	return false
}
