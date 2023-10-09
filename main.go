package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
)

const (
	dbUser = "root"
	dbHost = "localhost"
	dbName = "preview_week3"
)

func main() {
	db, err := sql.Open("mysql", fmt.Sprintf("%s:@tcp(%s)/%s", dbUser, dbHost, dbName))
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	if len(os.Args) < 2 {
		fmt.Println("Please specify a command: books, sales, customers, topauthor")
		return
	}

	command := os.Args[1]
	switch command {

	case "books":
		// TODO: Logic to list books by 'jane Smith'
		rows, err := db.Query(`
			SELECT b.book_title
			FROM Books AS b
			INNER JOIN Authors AS a ON b.author_id = a.author_id
			WHERE a.author_name = 'Jane Smith'
		`)
		if err != nil {
			log.Fatal(err)
		}
		defer rows.Close()

		for rows.Next() {
			var bookTitle string
			if err := rows.Scan(&bookTitle); err != nil {
				log.Fatal(err)
			}
			fmt.Println(bookTitle)
		}

	case "sales":
		// TODO: Logic to list sales by book type

		rows, err := db.Query(`
			SELECT bt.book_type_name, SUM(s.quantity) AS total_sales
			FROM sales AS s
			INNER JOIN Books AS b ON s.book_id = b.book_id
			INNER JOIN BookTypes AS bt ON b.book_type_id = bt.book_type_id
			GROUP BY bt.book_type_name
		`)
		if err != nil {
			log.Fatal(err)
		}
		defer rows.Close()

		fmt.Println("Total sales for each book type:")
		for rows.Next() {
			var bookTypeName string
			var totalSales float64
			if err := rows.Scan(&bookTypeName, &totalSales); err != nil {
				log.Fatal(err)
			}
			fmt.Printf("%s: %.6f\n", bookTypeName, totalSales)
		}

	case "customers":
		// TODO: Logic to identify customers who ordered more than one book
		rows, err := db.Query(`
			SELECT
			    c.customer_name,
			    COUNT(o.order_id) AS total_orders
			FROM Customers AS c
			JOIN Orders AS o ON c.customer_id = o.customer_id
			GROUP BY c.customer_id
			HAVING total_orders > 1;
		`)
		if err != nil {
			log.Fatal(err)
		}
		defer rows.Close()

		fmt.Println("Customers who ordered more than one book:")
		for rows.Next() {
			var customerName string
			var totalOrders int
			if err := rows.Scan(&customerName, &totalOrders); err != nil {
				log.Fatal(err)
			}
			fmt.Printf("%s: %d orders\n", customerName, totalOrders)
		}

	case "topauthor":
		// TODO: Logic to display the author whit the highest earnings
		rows, err := db.Query(`
		SELECT
			a.author_name,
			FORMAT(SUM(bp.price), 2) AS total_earnings
		FROM Authors AS a
		JOIN Books AS b ON a.author_id = b.author_id
		JOIN BookPrices AS bp ON b.book_id = bp.book_id
		GROUP BY a.author_name
		ORDER BY total_earnings DESC
		LIMIT 1;		
		`)
		if err != nil {
			log.Fatal(err)
		}
		defer rows.Close()

		for rows.Next() {
			var authorName string
			var totalEarnings float64
			if err := rows.Scan(&authorName, &totalEarnings); err != nil {
				log.Fatal(err)
			}
			formattedEarnings := fmt.Sprintf("%.2f", totalEarnings)
			fmt.Printf("Author: %s, Total Earnings: $%s\n", authorName, formattedEarnings)
		}

	default:
		fmt.Println("Unknow command", command)
	}
}
