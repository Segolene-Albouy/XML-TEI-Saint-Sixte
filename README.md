# Edition numérique
Ce projet consiste en l'édition en `XML TEI` de la vie de saint Sixte (folios 87ra à 88va) du manuscrit [Français 412](https://archivesetmanuscrits.bnf.fr/ark:/12148/cc50522d) conservé à la Bibliothèque nationale de France et disponible en [version numérisée](https://gallica.bnf.fr/ark:/12148/btv1b84259980/f183.image). Une version en ligne de cette édition existe à l'adresse suivante : [edition-saint-sixte](http://edition-saint-sixte.alwaysdata.net/)

## Transformation `XSLT`
Le fichier de transformation `XSLT` propose pour les fichiers `XML TEI` conformes au [schéma Relax NG](https://github.com/Segolene-Albouy/Edition_numerique_saint-Sixte/blob/master/DOCUMENTATION/ODD-Sixte.rng) fourni, une sortie automatique en six [fichiers HMTL](https://github.com/Segolene-Albouy/Edition_numerique_saint-Sixte/tree/master/HTML) :
- **Accueil** : bannière reprenant la reproduction du premier folio du manuscrit édité ainsi qu'un court paragraphe de présentation de la présente édition ;
- **Transcription** : affichage comparé entre une transcription du manuscrit diplomatique et une modernisée ;
- **Facsimilé interactif** : édition du texte associée à la reproduction graphique du manuscrit, avec le choix entre une version de la transcription au plus près du texte, et une version à la graphie modernisée. Vous pourrez trouver de plus amples informations sur le *repository* [Interfaxim](https://github.com/TimotheAlbouy/Interfaxim) ;
- **Analyse textométrique** : un onglet recensant toutes les occurences dans le texte de mention de personnages, un onglet pour les occurences de lieux et un dernier onglet listant toutes les prises de paroles par personnage ;
- **Notice** : description matérielle et bibliographique du manuscrit édité ;
- **Bibliographie** : liste des références bibliographiques mentionnant le manuscrit édité ;
- **À propos** : page à configurer pour donner des détails concernant le projet de l'édition.

