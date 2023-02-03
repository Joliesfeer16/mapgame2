boolean hitGround(FBox b) {
  ArrayList <FContact> contactList = player.getContacts();
  if (contactList.size()>0) {
    return true;
  }
  return false;
}
