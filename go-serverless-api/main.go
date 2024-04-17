package main

import (
	"github.com/gin-gonic/gin"
	"os"
)

func main() {
	r := gin.Default()

	publicPath := r.Group(os.Getenv("BASE_API_PATH"))
	{
		publicPath.GET("/", func(c *gin.Context) {
			c.JSON(200, gin.H{
				"message": "Hello from go-serverless-api",
			})
		})

		publicPath.GET("/ping", func(c *gin.Context) {
			c.JSON(200, gin.H{
				"message": "pong",
			})
		})
	}

	r.Run()
}
