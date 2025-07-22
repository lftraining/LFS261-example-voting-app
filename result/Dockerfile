FROM  node:24.4.1-slim
WORKDIR /app
COPY . .
RUN npm install && \
	npm audit fix
EXPOSE 4000
CMD ["npm", "start"]
