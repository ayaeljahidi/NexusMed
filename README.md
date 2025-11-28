# NexusMed – Système de Gestion Hospitalière Intelligente

## 📋 Description du Projet
**NexusMed** est une plateforme complète de gestion hospitalière basée sur des technologies XML modernes.  
Le système offre une solution intégrée pour la gestion des données médicales, des consultations, des prescriptions et du suivi des patients.

---

## 🏗️ Architecture Technique

### Structure des Fichiers
- **NexusMed.xml** – Fichier principal contenant toutes les informations hospitalières  
- **NexusMed.xsd** – Schéma XML définissant la structure et les contraintes de validation  
- **NexusMed.xsl** – Feuille de style XSLT pour la transformation et l'affichage web  

### Technologies Utilisées
- **XML** – Format de données principal  
- **XSD** – Validation et structure des données  
- **XSLT** – Transformation XML → HTML  
- **CSS3** – Interface utilisateur moderne et responsive  
- **JavaScript** – Interactions dynamiques  

---

## 🎯 Fonctionnalités Principales

### 1. Gestion du Personnel Médical
- Profils complets des médecins  
- Spécialités et services  
- Coordonnées multiples (téléphone, email)  
- Statut d'activité  

### 2. Dossiers Patients
- Informations démographiques  
- Historique d'admission  
- Adresses et contacts  
- Numéros de dossier uniques  

### 3. Système de Consultations
- Enregistrement des consultations  
- Diagnostics détaillés  
- Prescriptions médicamenteuses  
- Liaison médecin-patient  

### 4. Gestion des Médicaments
- Informations complètes des médicaments  
- Posologie et durée de traitement  
- Dates de péremption  
- Laboratoires fabricants  

### 5. Contrôles Médicaux
- Suivi post-consultation  
- Évaluation de la qualité des soins  
- Avis médicaux structurés  
- Historique de suivi  

---

## 🗃️ Structure des Données

### Entités Principales

| Entité             | Clé Primaire     | Description               |
|-------------------|-----------------|---------------------------|
| medecin           | numero_somme     | Personnel médical         |
| patient           | numero_dossier   | Patients de l'hôpital     |
| consultation      | code             | Rendez-vous médicaux      |
| medicament        | code             | Prescriptions             |
| controle_medical  | -                | Suivi médical             |

### Relations et Clés Étrangères
- Consultation → Médecin (`ref_medecin`)  
- Consultation → Patient (`ref_patient`)  
- Contrôle → Consultation (`ref_consultation`)  
- Avis → Médecin (`ref_medecin`)  

---

## 🎨 Interface Utilisateur

### Design Moderne
- Interface **glassmorphism**  
- Animations fluides  
- Design responsive  
- Palette de couleurs professionnelle  

### Tableaux de Bord
- **Dashboard Statistiques** – Vue d'ensemble des indicateurs clés  
- **Équipe Médicale** – Liste des médecins avec statuts  
- **Dossiers Patients** – Gestion complète des patients  
- **Consultations** – Historique et prescriptions  
- **Contrôles** – Suivi et évaluations  

---

## 🔒 Validation des Données

### Contraintes XSD
- Types de données strictes (dates, emails, téléphones)  
- Énumérations pour valeurs prédéfinies  
- Patterns pour validation formatée  
- Clés primaires et étrangères  

### Exemples de Validation
- Numéros de téléphone marocains (10 chiffres)  
- Formats d'email valides  
- Dates au format ISO  
- Spécialités médicales prédéfinies  

---

## 📊 Métriques et Statistiques
Le système fournit des indicateurs en temps réel :  
- Nombre de médecins spécialisés  
- Patients suivis  
- Consultations effectuées  
- Contrôles médicaux actifs  

---

## 🚀 Fonctionnalités Avancées

### Recherche et Filtrage
- Intégration des clés XSLT pour les jointures  
- Navigation relationnelle entre entités  
- Affichage contextuel des informations  

### Expérience Utilisateur
- Animations CSS avancées  
- États de survol interactifs  
- Design adaptatif mobile/desktop  
- Feedback visuel immédiat  

---

## 📱 Compatibilité
- Navigateurs modernes  
- Dispositifs mobiles  
- Tablettes et desktop  
- Résolutions multiples  

---

## 🔮 Extensions Possibles
- Système d'authentification  
- Export de rapports PDF  
- API REST pour intégration  
- Notifications en temps réel  
- Analyse prédictive des données  

---

**NexusMed** représente une solution complète et moderne pour la gestion hospitalière, combinant robustesse technique et expérience utilisateur exceptionnelle.
