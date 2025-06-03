0. Security:
1. Infrastructure:
    - Terraform
    - AWS: VPC, IGW, SUBNETS(4 Public), SG(2), ROUTES, EC2(4), ALB
    - Trên các nodes cần cài Docker, Compose,
    - Chọn 1 node làm Manager và thực thi lệnh để khởi tạo Cluster: `docker swarm init --advertise-addr <MANAGER_IP>`
    - Xuất hiện lệnh join, thêm lệnh đó vào các Worker Nodes mong muốn
    - Xem Cluster: `docker node ls`
    - Tạo service: `docker service create --name <> --relicas <> -p <>:<> <image>:<tag>`
2. App:
    - REACTJS
    - Web Server - Nginx
    - npm run build -> dist
    - Dockerfile -> Build image -> Push to Dockerhub
3. CI/CD Pipeline - Jenkins
    - Jenkins server cùng VPC với Cluster
    - Jenkins server kết nối với Manager node của Cluster qua Jenkins Agent (Agent cần cài java tương ứng vs Jenkins server)
        - Tạo user jenkins trên Agent vào thêm vào groups sudo, docker
        - Tạo thư mục /var/lib/jenkins/ và chuyển quyền sở hữu cho user jenkins
        - 
    - Jenkins server kết nối với Dockerhub                                              
4. Version Control - Github + Webhook
5. Deploy:
    - Docker
    - Dockerhub
    - Docker Swarm
    - Xem service: `docker service ls`
    - Deploy lên Swarm: `docker stack deploy -c docker-compose.yml <service_name>`