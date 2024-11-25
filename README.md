# Schizophrenia Detection Based on Morphometry of Hippocampus and Amygdala



The source code for our manuscript titled *"Schizophrenia Detection Based on Morphometry of Hippocampus and Amygdala"* is currently under peer review at **IEEE Journal of Biomedical and Health Informatics (IEEE JBHI)**. The manuscript is authored by **Qunxi Dong, Yuhang Sheng, Junru Zhu, Zhigang Li, Weijia Liu, Jingyu Liu, Yalin Wang, and Bin Hu **.



Schizophrenia (SZ) is a severe mental disorder characterized by hallucinations, delusions, cognitive impairments, and social withdrawal. It leads to a series of brain abnormalities, particularly the deformation of the hippocampus and amygdala, which are highly associated with emotion, memory, and motivation. Most previous studies have used the hippocampal and amygdaloid volume, whereas surface-based morphometry reflects nuclear deformation more finely, but it is unclear the hippocampal and amygdaloid morphometry relates to schizophrenic pathology and its potential as a biomarker. In this study, we extracted individual multivariate morphometry statistics (MMS) of hippocampus and amygdala from MRI images and analyzed the morphometric differences between groups. After dictionary learning and max pooling, we obtain reduced dimensional features and use machine learning algorithms for individual diagnosis. The results showed that the hippocampus of the schizophrenia group was significantly atrophied bilaterally and the atrophied areas were symmetrical. Subregions of the amygdala are both atrophied and expanded, and in particular, the right amygdala shows a greater degree and extent of deformation. Using the random forest classifier, the accuracy of classification using hippocampal and amygdaloid  morphometric features are 94.52\% and 94.57%, respectively, and the accuracy of classification combining the two morphometric features reached 96.57%. Our study demonstrates the efficacy of MMS in identifying  morphometric differences of the hippocampus and amygdala between healthy controls and schizophrenic, and these findings emphasize the potential of MMS as a reliable biomarker for the diagnosis of schizophrenia.



Authors:

```
Qunxi Dong, email: dongqx@bit.edu.cn
Yuhang Sheng, email: 3220222190@bit.edu.cn
```



The project is organized into three main components, each stored in a separate folder:

1. **Deformation_Analysis**: This folder contains analyses of deformation directions and magnitudes.
2. **Patch_Select**: Based on the results from *Deformation_Analysis*, this folder focuses on extracting patches.(The .m files can be opened and visualized using G3dOGL.exe.)
3. **Test_Features**: This folder stores the testing data used in our study.
