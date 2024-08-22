# Devops-project-2



sudo usermod -aG docker ubuntu

docker run -it --rm -d -p 8080:80 --name web nginx



pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Compilation, tests, etc.
            }
        }
        stage('Deploy to Test') {
            steps {
                // Déploiement de l'application sur l'environnement de test
            }
        }
        stage('Security Test with ZAP') {
            steps {
                sh '''
                zap.sh -daemon -port 8080 -config api.disablekey=true
                zap-cli quick-scan --self-contained --start-options '-config api.key=12345' http://test-app-url
                zap-cli report -o zap_report.html -f html
                '''
            }
        }

    }
    post {
        always {
            archiveArtifacts artifacts: 'zap_report.html', allowEmptyArchive: true
        }
    }
}




1. Utilisation du Plugin Jenkins pour OWASP ZAP
Jenkins propose un plugin spécifique pour OWASP ZAP qui simplifie son intégration dans une pipeline.

Installation du plugin :
Accédez à Jenkins, puis allez dans Manage Jenkins > Manage Plugins.
Sous l'onglet Available, recherchez "OWASP ZAP".
Installez le plugin.
Configuration du plugin :
Configurer ZAP dans Jenkins :

Après l'installation, allez dans Manage Jenkins > Global Tool Configuration.
Ajoutez une nouvelle installation de ZAP en spécifiant l'emplacement du fichier exécutable de ZAP (zap.sh pour Linux ou zap.bat pour Windows).
Ajout de ZAP dans un pipeline Jenkins :

Dans votre Jenkinsfile, vous pouvez maintenant utiliser des étapes spécifiques du plugin pour lancer un scan ZAP. Voici un exemple simple :
groovy
Copier le code
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Compilation, tests unitaires, etc.
            }
        }
        stage('Deploy to Test') {
            steps {
                // Déploiement de l'application sur l'environnement de test
            }
        }
        stage('Security Scan with OWASP ZAP') {
            steps {
                zapStart(zapHome: '/path/to/zap', host: 'localhost', port: '8080', timeout: 10000)
                zapAttackScan(target: 'http://test-app-url')
                zapReport(reportFile: 'zap_report.html', reportTitle: 'ZAP Security Report', format: 'html')
                zapStop()
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'zap_report.html', allowEmptyArchive: true
        }
    }
}
2. Utilisation de Scripts Personnalisés dans le Jenkinsfile
Si vous préférez ne pas utiliser le plugin ou si vous souhaitez un contrôle plus fin sur l'exécution de ZAP, vous pouvez utiliser des commandes personnalisées dans votre pipeline Jenkins.

Voici comment vous pourriez configurer cela :

Lancer ZAP en mode daemon :

OWASP ZAP peut être lancé en mode "headless" pour qu'il fonctionne sans interface graphique, idéal pour une intégration CI/CD.
groovy
Copier le code
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Compilation, tests unitaires, etc.
            }
        }
        stage('Deploy to Test') {
            steps {
                // Déploiement de l'application sur l'environnement de test
            }
        }
        stage('Security Scan with OWASP ZAP') {
            steps {
                sh '''
                zap.sh -daemon -port 8080 -config api.disablekey=true
                zap-cli quick-scan --self-contained --start-options '-config api.key=12345' http://test-app-url
                zap-cli report -o zap_report.html -f html
                '''
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'zap_report.html', allowEmptyArchive: true
        }
    }
}
Arrêter ZAP après le scan :

Assurez-vous d'arrêter le processus ZAP après le scan pour libérer les ressources.





Pour vérifier si Kubernetes est bien installé sur ta machine, voici quelques commandes utiles :

1. Vérifier si kubectl est installé
kubectl est l'outil en ligne de commande pour interagir avec un cluster Kubernetes.

bash
Copier le code
kubectl version --client
Cette commande affiche la version de kubectl installée. Si kubectl n'est pas installé, la commande renverra une erreur.

2. Vérifier l'état du cluster Kubernetes
Pour savoir si Kubernetes est bien installé et qu'un cluster est en cours d'exécution, utilise la commande suivante :

bash
Copier le code
kubectl cluster-info
Cette commande fournit des informations sur le cluster Kubernetes. Si un cluster est actif, tu verras les détails des composants principaux, tels que l'API Server.

3. Vérifier les nœuds dans le cluster
Si Kubernetes est installé et configuré correctement, tu devrais voir les nœuds dans le cluster avec cette commande :

bash
Copier le code
kubectl get nodes
Cette commande affiche la liste des nœuds du cluster. Si le cluster est en bon état de marche, tu devrais voir une ou plusieurs lignes avec des informations sur les nœuds.

4. Vérifier les Pods dans le namespace kube-system
Kubernetes déploie plusieurs composants critiques dans le namespace kube-system. Pour vérifier si ces composants sont en cours d'exécution :

bash
Copier le code
kubectl get pods -n kube-system
Cela listera les pods essentiels comme le kube-apiserver, etcd, kube-scheduler, etc.

5. Vérifier l'accès à Internet depuis le cluster
Pour t'assurer que le cluster peut accéder à Internet, par exemple, pour tirer des images de Docker Hub :

bash
Copier le code
kubectl run --rm -it --image=busybox --restart=Never busybox -- /bin/sh
Ensuite, à l'intérieur du pod BusyBox :

bash
Copier le code
wget google.com
Si le téléchargement réussit, ton cluster a accès à Internet.



playbook kube https://github.com/torgeirl/kubernetes-playbooks

https://sysadmin.info.pl/en/blog/installing-configuring-and-removing-argo-cd-with-bash-and-ansible/

https://argo-cd.readthedocs.io/en/stable/operator-manual/installation/