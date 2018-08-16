module MedicinesHelper
  def medicine_image medicine
    medicine.image || Settings.default.medicine_image
  end
end
