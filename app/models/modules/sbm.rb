module Sbm

  def self.included(base)
    base.class_eval do
      has_many :sbm_answers, as: :sbm, dependent: :destroy
      has_many :submission_gradings, as: :sbm, dependent: :destroy

      default_scope includes(:submission_gradings)
    end
  end

  def get_asm
    raise NotImplementedError
  end

  def get_path
    throw NotImplementedError
  end

  def get_new_grading_path
    throw NotImplementedError
  end

  def get_final_grading
    if self.submission_gradings.count > 0
      self.submission_gradings.order("created_at").last
    else
      return nil
    end
  end

  def get_all_answers
    self.sbm_answers.map { |sbm| sbm.answer }
  end

  def clear_final_answer(qn)
    self.sbm_answers.final.each do |sbm_ans|
      if sbm_ans.answer.qn == qn
        sbm_ans.final = false
        sbm_ans.save
        break
      end
    end
  end

  def has_multiplier?
    self.respond_to?(:multiplier) && self.multiplier
  end

  def get_bonus
    if self.class == TrainingSubmission
      training = self.training
      if  training.bonus_cutoff && training.bonus_cutoff > Time.now
        return training.bonus_exp
      end
    end
    0
  end

  def set_attempting
    self.update_attribute(:status,'attempting')
  end

  def set_submitted(redirect_url = "", notify = true)
    self.update_attribute(:status,'submitted')
    self.update_attribute(:submit_at, updated_at)
    if notify
      notify_submission(redirect_url)
    end
  end

  def set_graded
    self.update_attribute(:status,'graded')
  end

  def attempting?
    self.status == 'attempting'
  end

  def submitted?
    self.status == 'submitted'
  end

  def graded?
    self.status == 'graded'
  end
end
