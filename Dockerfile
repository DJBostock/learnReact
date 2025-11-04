# Build the image
# docker build -t react-container .

# Run the container
# docker run -p 3000:80 react-container

# Frontend build
FROM node:20 AS frontend
WORKDIR /app/frontend
COPY frontend/package.json /app/frontend/
RUN npm install
COPY frontend/ /app/frontend/
RUN npm run build

# Backend build
FROM node:20 AS backend
WORKDIR /app/backend
COPY backend/package.json /app/backend/
RUN npm install
COPY backend/ /app/backend/

# Copy built React files into backend public folder
COPY --from=frontend /app/frontend/build ./public

EXPOSE 80

CMD ["node", "server.cjs"]