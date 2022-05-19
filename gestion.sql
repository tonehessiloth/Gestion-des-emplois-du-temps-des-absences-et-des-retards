-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 18 mai 2022 à 23:51
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestion`
--

-- --------------------------------------------------------

--
-- Structure de la table `cours`
--

DROP TABLE IF EXISTS `cours`;
CREATE TABLE IF NOT EXISTS `cours` (
  `numcours` int(11) NOT NULL AUTO_INCREMENT,
  `jour` date NOT NULL,
  `hdeb` datetime NOT NULL,
  `hfin` datetime NOT NULL,
  `codmat` int(11) NOT NULL,
  `codfil` int(11) NOT NULL,
  `numsal` int(11) NOT NULL,
  `numprof` int(11) NOT NULL,
  PRIMARY KEY (`numcours`),
  KEY `codmat` (`codmat`),
  KEY `codfil` (`codfil`),
  KEY `numsal` (`numsal`),
  KEY `numprof` (`numprof`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `cours_dispense`
--

DROP TABLE IF EXISTS `cours_dispense`;
CREATE TABLE IF NOT EXISTS `cours_dispense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numcours` int(11) NOT NULL,
  `datecours` int(11) NOT NULL,
  `hrdeb` datetime NOT NULL,
  `hrfin` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `numcours` (`numcours`),
  KEY `datecours` (`datecours`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

DROP TABLE IF EXISTS `etudiant`;
CREATE TABLE IF NOT EXISTS `etudiant` (
  `matricule` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `sexe` varchar(255) NOT NULL,
  PRIMARY KEY (`matricule`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `etudiants_absents`
--

DROP TABLE IF EXISTS `etudiants_absents`;
CREATE TABLE IF NOT EXISTS `etudiants_absents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numcours` int(11) NOT NULL,
  `matricule` int(11) NOT NULL,
  `datecours` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `numcours` (`numcours`),
  KEY `matricule` (`matricule`),
  KEY `datecours` (`datecours`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `filiere`
--

DROP TABLE IF EXISTS `filiere`;
CREATE TABLE IF NOT EXISTS `filiere` (
  `codfil` int(11) NOT NULL AUTO_INCREMENT,
  `libfil` int(11) NOT NULL,
  PRIMARY KEY (`codfil`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `inscription`
--

DROP TABLE IF EXISTS `inscription`;
CREATE TABLE IF NOT EXISTS `inscription` (
  `numins` int(11) NOT NULL AUTO_INCREMENT,
  `dateins` date NOT NULL,
  `annee` year(4) NOT NULL,
  `codfil` int(11) NOT NULL,
  `matricule` int(11) NOT NULL,
  PRIMARY KEY (`numins`),
  KEY `codfil` (`codfil`),
  KEY `matricule` (`matricule`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `matiere`
--

DROP TABLE IF EXISTS `matiere`;
CREATE TABLE IF NOT EXISTS `matiere` (
  `codmat` int(11) NOT NULL AUTO_INCREMENT,
  `libmat` int(11) NOT NULL,
  PRIMARY KEY (`codmat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `professeur`
--

DROP TABLE IF EXISTS `professeur`;
CREATE TABLE IF NOT EXISTS `professeur` (
  `numprof` int(11) NOT NULL AUTO_INCREMENT,
  `nomprof` varchar(255) NOT NULL,
  PRIMARY KEY (`numprof`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `responsable`
--

DROP TABLE IF EXISTS `responsable`;
CREATE TABLE IF NOT EXISTS `responsable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codefil` int(11) NOT NULL,
  `numins_respo1` int(11) NOT NULL,
  `numins_respo2` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `codefil` (`codefil`),
  KEY `numins_respo1` (`numins_respo1`),
  KEY `numins_respo2` (`numins_respo2`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `salle_de_cours`
--

DROP TABLE IF EXISTS `salle_de_cours`;
CREATE TABLE IF NOT EXISTS `salle_de_cours` (
  `numsal` int(11) NOT NULL AUTO_INCREMENT,
  `capacite` int(11) NOT NULL,
  `typesal` int(11) NOT NULL,
  PRIMARY KEY (`numsal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `cours`
--
ALTER TABLE `cours`
  ADD CONSTRAINT `cours_filiere_codfil` FOREIGN KEY (`codfil`) REFERENCES `filiere` (`codfil`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cours_matiere_codmat` FOREIGN KEY (`codmat`) REFERENCES `matiere` (`codmat`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cours_professeur_numprof` FOREIGN KEY (`numprof`) REFERENCES `professeur` (`numprof`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cours_salle_de_cours_numsal` FOREIGN KEY (`numsal`) REFERENCES `salle_de_cours` (`numsal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `cours_dispense`
--
ALTER TABLE `cours_dispense`
  ADD CONSTRAINT `cours_dispense_cours_numcours` FOREIGN KEY (`numcours`) REFERENCES `cours` (`numcours`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cours_dispense_etudiant_absents_datecours` FOREIGN KEY (`datecours`) REFERENCES `etudiants_absents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `etudiants_absents`
--
ALTER TABLE `etudiants_absents`
  ADD CONSTRAINT `etudiants_absents_cours_dispense_datecours` FOREIGN KEY (`datecours`) REFERENCES `cours_dispense` (`datecours`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `etudiants_absents_cours_numcours` FOREIGN KEY (`numcours`) REFERENCES `cours` (`numcours`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `etudiants_absents_etudiant_matricule` FOREIGN KEY (`matricule`) REFERENCES `etudiant` (`matricule`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `inscription`
--
ALTER TABLE `inscription`
  ADD CONSTRAINT `inscription_etudiant_matricule` FOREIGN KEY (`matricule`) REFERENCES `etudiant` (`matricule`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inscription_filiere_codefil` FOREIGN KEY (`codfil`) REFERENCES `filiere` (`codfil`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `responsable`
--
ALTER TABLE `responsable`
  ADD CONSTRAINT `responsable1_inscription_numins` FOREIGN KEY (`numins_respo1`) REFERENCES `inscription` (`numins`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `responsable2_inscription_numins` FOREIGN KEY (`numins_respo2`) REFERENCES `inscription` (`numins`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `responsable_filiere_codefil` FOREIGN KEY (`codefil`) REFERENCES `filiere` (`codfil`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
