    <?php
    
    require_once('../approot.inc.php');
    
    function AppUpgradeCheckInstall() {
	
		if ((version_compare(ITOP_VERSION, '2.7.0')<0) || (version_compare(ITOP_VERSION, '2.8.0')>=0)) {
			throw new Exception(ITOP_APPLICATION.' 2.7.8 cannot be installed automatically on '.ITOP_APPLICATION.' '.ITOP_VERSION.'. Please perform upgrade manually.');
		}
    }