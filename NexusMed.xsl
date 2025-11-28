<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Déclaration des clés au niveau racine -->
    <xsl:key name="medecin-key" match="medecin" use="@numero_somme"/>
    <xsl:key name="patient-key" match="patient" use="@numero_dossier"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>NexusMed - Intelligence Hospitalière</title>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet"/>
                <style>
                    <![CDATA[
                    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
                    
                    :root {
                        --primary: #6366f1;
                        --primary-dark: #4f46e5;
                        --secondary: #10b981;
                        --accent: #f59e0b;
                        --danger: #ef4444;
                        --light: #f8fafc;
                        --dark: #1e293b;
                        --gray: #64748b;
                        --border: #e2e8f0;
                        --card-bg: rgba(255, 255, 255, 0.95);
                        --glass: rgba(255, 255, 255, 0.1);
                        --shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                    }
                    
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }
                    
                    body {
                        font-family: 'Inter', sans-serif;
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: var(--dark);
                        line-height: 1.6;
                        min-height: 100vh;
                        position: relative;
                        overflow-x: hidden;
                    }
                    
                    body::before {
                        content: '';
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        background: 
                            radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                            radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.3) 0%, transparent 50%),
                            radial-gradient(circle at 40% 40%, rgba(120, 219, 255, 0.2) 0%, transparent 50%);
                        z-index: -1;
                    }
                    
                    .floating-elements {
                        position: fixed;
                        width: 100%;
                        height: 100%;
                        pointer-events: none;
                        z-index: -1;
                    }
                    
                    .floating-element {
                        position: absolute;
                        background: var(--glass);
                        border-radius: 50%;
                        animation: float 20s infinite linear;
                    }
                    
                    .floating-element:nth-child(1) {
                        width: 100px;
                        height: 100px;
                        top: 10%;
                        left: 10%;
                        animation-delay: 0s;
                    }
                    
                    .floating-element:nth-child(2) {
                        width: 150px;
                        height: 150px;
                        top: 60%;
                        left: 80%;
                        animation-delay: -5s;
                    }
                    
                    .floating-element:nth-child(3) {
                        width: 80px;
                        height: 80px;
                        top: 80%;
                        left: 20%;
                        animation-delay: -10s;
                    }
                    
                    @keyframes float {
                        0% { transform: translate(0, 0) rotate(0deg); }
                        33% { transform: translate(30px, -50px) rotate(120deg); }
                        66% { transform: translate(-20px, 20px) rotate(240deg); }
                        100% { transform: translate(0, 0) rotate(360deg); }
                    }
                    
                    .container {
                        max-width: 1400px;
                        margin: 0 auto;
                        padding: 20px;
                    }
                    
                    /* Header Styles */
                    .header {
                        text-align: center;
                        margin-bottom: 40px;
                        color: white;
                        position: relative;
                    }
                    
                    .header h1 {
                        font-size: 3.5rem;
                        font-weight: 800;
                        margin-bottom: 10px;
                        text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
                        background: linear-gradient(135deg, #fff 0%, #a5b4fc 100%);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        position: relative;
                        display: inline-block;
                    }
                    
                    .header h1::after {
                        content: '';
                        position: absolute;
                        bottom: -10px;
                        left: 50%;
                        transform: translateX(-50%);
                        width: 100px;
                        height: 4px;
                        background: linear-gradient(90deg, var(--primary), var(--secondary));
                        border-radius: 2px;
                    }
                    
                    .header p {
                        font-size: 1.3rem;
                        opacity: 0.9;
                        max-width: 600px;
                        margin: 0 auto;
                    }
                    
                    /* Dashboard Grid */
                    .dashboard {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                        gap: 25px;
                        margin-bottom: 40px;
                    }
                    
                    .stat-card {
                        background: var(--card-bg);
                        padding: 25px;
                        border-radius: 20px;
                        box-shadow: var(--shadow);
                        text-align: center;
                        transition: all 0.3s ease;
                        backdrop-filter: blur(10px);
                        border: 1px solid var(--glass);
                        position: relative;
                        overflow: hidden;
                    }
                    
                    .stat-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 5px;
                        background: linear-gradient(90deg, var(--primary), var(--secondary));
                    }
                    
                    .stat-card:hover {
                        transform: translateY(-10px);
                        box-shadow: 0 30px 60px rgba(0,0,0,0.3);
                    }
                    
                    .stat-icon {
                        font-size: 3rem;
                        margin-bottom: 15px;
                        display: inline-block;
                        padding: 15px;
                        border-radius: 15px;
                        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                        color: white;
                    }
                    
                    .stat-number {
                        font-size: 2.5rem;
                        font-weight: 800;
                        color: var(--primary);
                        margin-bottom: 5px;
                    }
                    
                    .stat-label {
                        color: var(--gray);
                        font-size: 1rem;
                        font-weight: 500;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                    }
                    
                    /* Section Styles */
                    .section {
                        background: var(--card-bg);
                        border-radius: 20px;
                        padding: 30px;
                        margin-bottom: 30px;
                        box-shadow: var(--shadow);
                        backdrop-filter: blur(10px);
                        border: 1px solid var(--glass);
                        position: relative;
                        overflow: hidden;
                    }
                    
                    .section::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 8px;
                        height: 100%;
                        background: linear-gradient(to bottom, var(--primary), var(--secondary));
                    }
                    
                    .section-header {
                        display: flex;
                        align-items: center;
                        margin-bottom: 25px;
                        padding-bottom: 15px;
                        border-bottom: 2px solid var(--border);
                    }
                    
                    .section-icon {
                        font-size: 2rem;
                        margin-right: 15px;
                        color: var(--primary);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        width: 60px;
                        height: 60px;
                        border-radius: 15px;
                        background: linear-gradient(135deg, #e0e7ff, #c7d2fe);
                    }
                    
                    .section-title {
                        font-size: 1.8rem;
                        font-weight: 700;
                        color: var(--dark);
                    }
                    
                    /* Table Styles */
                    .table-container {
                        overflow: hidden;
                        border-radius: 15px;
                        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
                    }
                    
                    table {
                        width: 100%;
                        border-collapse: collapse;
                        background: white;
                    }
                    
                    th {
                        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                        color: white;
                        padding: 18px 15px;
                        text-align: left;
                        font-weight: 600;
                        font-size: 0.9rem;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                        position: relative;
                    }
                    
                    th::after {
                        content: '';
                        position: absolute;
                        bottom: 0;
                        left: 0;
                        width: 100%;
                        height: 2px;
                        background: rgba(255,255,255,0.3);
                    }
                    
                    td {
                        padding: 16px 15px;
                        border-bottom: 1px solid var(--border);
                        transition: all 0.2s ease;
                    }
                    
                    tr {
                        transition: all 0.2s ease;
                    }
                    
                    tr:hover {
                        background-color: #f8fafc;
                        transform: scale(1.01);
                        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                    }
                    
                    tr:last-child td {
                        border-bottom: none;
                    }
                    
                    /* Badge Styles */
                    .badge {
                        display: inline-block;
                        padding: 6px 14px;
                        border-radius: 25px;
                        font-size: 0.8rem;
                        font-weight: 600;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }
                    
                    .badge-success {
                        background: linear-gradient(135deg, #10b981, #059669);
                        color: white;
                    }
                    
                    .badge-warning {
                        background: linear-gradient(135deg, #f59e0b, #d97706);
                        color: white;
                    }
                    
                    .badge-primary {
                        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                        color: white;
                    }
                    
                    .badge-danger {
                        background: linear-gradient(135deg, var(--danger), #dc2626);
                        color: white;
                    }
                    
                    /* Special Elements */
                    .medicament-info {
                        background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
                        border-radius: 12px;
                        padding: 12px;
                        margin-top: 5px;
                        border-left: 4px solid var(--secondary);
                    }
                    
                    .patient-avatar {
                        width: 40px;
                        height: 40px;
                        border-radius: 50%;
                        background: linear-gradient(135deg, var(--primary), var(--secondary));
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        font-weight: bold;
                        margin-right: 10px;
                    }
                    
                    .doctor-avatar {
                        width: 40px;
                        height: 40px;
                        border-radius: 50%;
                        background: linear-gradient(135deg, var(--accent), #f97316);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        font-weight: bold;
                        margin-right: 10px;
                    }
                    
                    .status-indicator {
                        display: inline-block;
                        width: 10px;
                        height: 10px;
                        border-radius: 50%;
                        margin-right: 8px;
                    }
                    
                    .status-active {
                        background: var(--secondary);
                        box-shadow: 0 0 10px var(--secondary);
                    }
                    
                    .status-inactive {
                        background: var(--gray);
                    }
                    
                    /* Footer */
                    .footer {
                        text-align: center;
                        padding: 30px;
                        color: white;
                        opacity: 0.8;
                        font-size: 0.9rem;
                    }
                    
                    /* Responsive Design */
                    @media (max-width: 768px) {
                        .dashboard {
                            grid-template-columns: 1fr;
                        }
                        
                        .header h1 {
                            font-size: 2.5rem;
                        }
                        
                        .table-container {
                            overflow-x: auto;
                        }
                        
                        .section {
                            padding: 20px;
                        }
                    }
                    
                    /* Animation for elements */
                    @keyframes fadeInUp {
                        from {
                            opacity: 0;
                            transform: translateY(30px);
                        }
                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }
                    
                    .fade-in {
                        animation: fadeInUp 0.6s ease forwards;
                    }
                    
                    /* Custom scrollbar */
                    ::-webkit-scrollbar {
                        width: 8px;
                    }
                    
                    ::-webkit-scrollbar-track {
                        background: rgba(255,255,255,0.1);
                        border-radius: 10px;
                    }
                    
                    ::-webkit-scrollbar-thumb {
                        background: linear-gradient(135deg, var(--primary), var(--secondary));
                        border-radius: 10px;
                    }
                    
                    ::-webkit-scrollbar-thumb:hover {
                        background: linear-gradient(135deg, var(--primary-dark), #059669);
                    }
                    ]]>
                </style>
            </head>
            <body>
                <!-- Floating Background Elements -->
                <div class="floating-elements">
                    <div class="floating-element"></div>
                    <div class="floating-element"></div>
                    <div class="floating-element"></div>
                </div>
                
                <div class="container">
                    <!-- Header -->
                    <div class="header fade-in">
                        <h1>NexusMed Intelligence</h1>
                        <p>Plateforme de gestion hospitalière avancée - Surveillance en temps réel et analyses prédictives</p>
                    </div>
                    
                    <!-- Statistics Dashboard -->
                    <div class="dashboard">
                        <div class="stat-card fade-in">
                            <div class="stat-icon">👨‍⚕️</div>
                            <div class="stat-number">
                                <xsl:value-of select="count(Hopital/medecin)"/>
                            </div>
                            <div class="stat-label">Médecins Spécialisés</div>
                        </div>
                        
                        <div class="stat-card fade-in">
                            <div class="stat-icon">🧍</div>
                            <div class="stat-number">
                                <xsl:value-of select="count(Hopital/patient)"/>
                            </div>
                            <div class="stat-label">Patients Suivis</div>
                        </div>
                        
                        <div class="stat-card fade-in">
                            <div class="stat-icon">🩺</div>
                            <div class="stat-number">
                                <xsl:value-of select="count(Hopital/consultation)"/>
                            </div>
                            <div class="stat-label">Consultations</div>
                        </div>
                        
                        <div class="stat-card fade-in">
                            <div class="stat-icon">📊</div>
                            <div class="stat-number">
                                <xsl:value-of select="count(Hopital/controle_medical)"/>
                            </div>
                            <div class="stat-label">Contrôles Actifs</div>
                        </div>
                    </div>
                    
                    <!-- Médecins Section -->
                    <div class="section fade-in">
                        <div class="section-header">
                            <div class="section-icon">
                                <i class='bx bx-user-md'></i>
                            </div>
                            <h2 class="section-title">Équipe Médicale Spécialisée</h2>
                        </div>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Identifiant</th>
                                        <th>Médecin</th>
                                        <th>Spécialité</th>
                                        <th>Service</th>
                                        <th>Coordonnées</th>
                                        <th>Statut</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:for-each select="Hopital/medecin">
                                        <tr>
                                            <td>
                                                <span class="badge badge-primary">
                                                    <xsl:value-of select="@numero_somme"/>
                                                </span>
                                            </td>
                                            <td>
                                                <div style="display: flex; align-items: center;">
                                                    <div class="doctor-avatar">
                                                        <xsl:value-of select="substring(@prenom, 1, 1)"/><xsl:value-of select="substring(@nom, 1, 1)"/>
                                                    </div>
                                                    <div>
                                                        <strong><xsl:value-of select="@prenom"/><xsl:text> </xsl:text><xsl:value-of select="@nom"/></strong>
                                                        <div style="font-size: 0.8rem; color: var(--gray);">CIN: <xsl:value-of select="@cin"/></div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge badge-success">
                                                    <xsl:value-of select="@specialite"/>
                                                </span>
                                            </td>
                                            <td><xsl:value-of select="@service"/></td>
                                            <td>
                                                <div style="display: flex; flex-direction: column; gap: 5px;">
                                                    <xsl:for-each select="phone">
                                                        <span>📞 <xsl:value-of select="numero"/> (<xsl:value-of select="type"/>)</span>
                                                    </xsl:for-each>
                                                    <xsl:for-each select="email">
                                                        <span>📧 <xsl:value-of select="adresse"/> (<xsl:value-of select="categorie"/>)</span>
                                                    </xsl:for-each>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="status-indicator status-active"></span>
                                                Actif
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <!-- Patients Section -->
                    <div class="section fade-in">
                        <div class="section-header">
                            <div class="section-icon">
                                <i class='bx bx-group'></i>
                            </div>
                            <h2 class="section-title">Dossiers Patients</h2>
                        </div>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Dossier</th>
                                        <th>Patient</th>
                                        <th>Genre</th>
                                        <th>Date Admission</th>
                                        <th>Adresse</th>
                                        <th>Contact</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:for-each select="Hopital/patient">
                                        <tr>
                                            <td>
                                                <span class="badge badge-primary">
                                                    <xsl:value-of select="@numero_dossier"/>
                                                </span>
                                            </td>
                                            <td>
                                                <div style="display: flex; align-items: center;">
                                                    <div class="patient-avatar">
                                                        <xsl:value-of select="substring(@prenom, 1, 1)"/><xsl:value-of select="substring(@nom, 1, 1)"/>
                                                    </div>
                                                    <div>
                                                        <strong><xsl:value-of select="@prenom"/><xsl:text> </xsl:text><xsl:value-of select="@nom"/></strong>
                                                        <div style="font-size: 0.8rem; color: var(--gray);">CIN: <xsl:value-of select="@cin"/></div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <xsl:choose>
                                                    <xsl:when test="@genre='feminin'">
                                                        <span class="badge badge-warning">👩 Feminin</span>
                                                    </xsl:when>
                                                    <xsl:when test="@genre='masculin'">
                                                        <span class="badge badge-primary">👨 Masculin</span>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <span class="badge"><xsl:value-of select="@genre"/></span>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </td>
                                            <td>
                                                <strong><xsl:value-of select="@date"/></strong>
                                            </td>
                                            <td>
                                                <xsl:for-each select="adresse">
                                                    <div>
                                                        🏠 <xsl:value-of select="@rue"/>, 
                                                        <xsl:value-of select="@numero"/> - 
                                                        <xsl:value-of select="@ville"/>
                                                    </div>
                                                </xsl:for-each>
                                            </td>
                                            <td>
                                                <div style="display: flex; flex-direction: column; gap: 5px;">
                                                    <xsl:for-each select="phone">
                                                        <span>📞 <xsl:value-of select="numero"/> (<xsl:value-of select="type"/>)</span>
                                                    </xsl:for-each>
                                                    <xsl:for-each select="email">
                                                        <span>📧 <xsl:value-of select="adresse"/> (<xsl:value-of select="categorie"/>)</span>
                                                    </xsl:for-each>
                                                </div>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <!-- Consultations Section -->
                    <div class="section fade-in">
                        <div class="section-header">
                            <div class="section-icon">
                                <i class='bx bx-clipboard'></i>
                            </div>
                            <h2 class="section-title">Consultations &amp; Traitements</h2>
                        </div>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Référence</th>
                                        <th>Date &amp; Heure</th>
                                        <th>Diagnostic</th>
                                        <th>Médecin</th>
                                        <th>Patient</th>
                                        <th>Prescription</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:for-each select="Hopital/consultation">
                                        <tr>
                                            <td>
                                                <span class="badge badge-primary">
                                                    <xsl:value-of select="@code"/>
                                                </span>
                                            </td>
                                            <td>
                                                <div style="display: flex; flex-direction: column;">
                                                    <strong>📅 <xsl:value-of select="@date"/></strong>
                                                    <span>⏰ <xsl:value-of select="@heure"/></span>
                                                </div>
                                            </td>
                                            <td>
                                                <strong style="color: var(--primary-dark);">
                                                    <xsl:value-of select="@diagnostique"/>
                                                </strong>
                                            </td>
                                            <td>
                                                <xsl:variable name="medecinRef" select="@ref_medecin"/>
                                                <xsl:for-each select="key('medecin-key', $medecinRef)">
                                                    <span class="badge badge-success">
                                                        Dr. <xsl:value-of select="@prenom"/><xsl:text> </xsl:text><xsl:value-of select="@nom"/>
                                                    </span>
                                                </xsl:for-each>
                                            </td>
                                            <td>
                                                <xsl:variable name="patientRef" select="@ref_patient"/>
                                                <xsl:for-each select="key('patient-key', $patientRef)">
                                                    <span class="badge badge-warning">
                                                        <xsl:value-of select="@prenom"/><xsl:text> </xsl:text><xsl:value-of select="@nom"/>
                                                    </span>
                                                </xsl:for-each>
                                            </td>
                                            <td>
                                                <div class="medicament-info">
                                                    <div style="display: flex; align-items: center; margin-bottom: 8px;">
                                                        <span style="font-size: 1.2rem; margin-right: 8px;">💊</span>
                                                        <strong><xsl:value-of select="medicament/@nom_commercial"/></strong>
                                                    </div>
                                                    <div style="font-size: 0.9rem;">
                                                        <div>📝 <xsl:value-of select="medicament/@posologie"/></div>
                                                        <div>⏱️ Durée: <xsl:value-of select="medicament/@duree_traitement"/></div>
                                                        <div>🏭 Labo: <xsl:value-of select="medicament/@labo_fabricant"/></div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <!-- Contrôles Médicaux Section -->
                    <div class="section fade-in">
                        <div class="section-header">
                            <div class="section-icon">
                                <i class='bx bx-line-chart'></i>
                            </div>
                            <h2 class="section-title">Suivi &amp; Évaluations Médicales</h2>
                        </div>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Date Contrôle</th>
                                        <th>Consultation</th>
                                        <th>Médecin</th>
                                        <th>Qualité Diagnostic</th>
                                        <th>Qualité Traitement</th>
                                        <th>Avis Médical</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:for-each select="Hopital/controle_medical">
                                        <xsl:for-each select="avis">
                                            <tr>
                                                <td>
                                                    <strong>📅 <xsl:value-of select="../@date"/></strong>
                                                </td>
                                                <td>
                                                    <span class="badge badge-primary">
                                                        <xsl:value-of select="../@ref_consultation"/>
                                                    </span>
                                                </td>
                                                <td>
                                                    <xsl:variable name="medecinRef" select="@ref_medecin"/>
                                                    <xsl:for-each select="key('medecin-key', $medecinRef)">
                                                        <span class="badge badge-success">
                                                            Dr. <xsl:value-of select="@prenom"/><xsl:text> </xsl:text><xsl:value-of select="@nom"/>
                                                        </span>
                                                    </xsl:for-each>
                                                </td>
                                                <td>
                                                    <span class="badge badge-success">
                                                        <xsl:value-of select="@qualite_diagnostic"/>
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="badge badge-warning">
                                                        <xsl:value-of select="@qualite_traitement"/>
                                                    </span>
                                                </td>
                                                <td>
                                                    <div style="background: #f0f9ff; padding: 10px; border-radius: 8px; border-left: 3px solid var(--primary);">
                                                        💬 "<xsl:value-of select="@avis"/>"
                                                    </div>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </xsl:for-each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <!-- Footer -->
                    <div class="footer fade-in">
                        <p>NexusMed Intelligence Platform • Système de Gestion Hospitalière Avancée • © 2025</p>
                    </div>
                </div>
                
                <script>
                    <![CDATA[
                    document.addEventListener('DOMContentLoaded', function() {
                        const fadeElements = document.querySelectorAll('.fade-in');
                        
                        fadeElements.forEach((el, index) => {
                            el.style.animationDelay = `${index * 0.1}s`;
                        });
                        
                        const tableRows = document.querySelectorAll('tbody tr');
                        tableRows.forEach(row => {
                            row.addEventListener('mouseenter', function() {
                                this.style.transform = 'scale(1.01)';
                                this.style.boxShadow = '0 5px 15px rgba(0,0,0,0.1)';
                            });
                            
                            row.addEventListener('mouseleave', function() {
                                this.style.transform = 'scale(1)';
                                this.style.boxShadow = 'none';
                            });
                        });
                    });
                    ]]>
                </script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>