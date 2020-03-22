class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:show, :destroy, :update, :edit]
    
    def index
        @tasks = current_user.tasks.order(id: :desc)
    end
    
    def show
    end
    
    def new
        @task = current_user.tasks.build
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = 'タスクが正常に作成されました'
            redirect_to root_url
        else
            flash.now[:danger] = 'タスクを作成できませんでした'
            render :new
        end
    end
    
    def edit
    end
    
    def update
       
        if @task.update(task_params)
            flash[:success] = 'タスクは正常に変更されました'
            redirect_to root_url
        else
            flash.now[:danger] = 'タスクを更新できませんでした'
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = 'タスクを正常に削除できました'
        redirect_back(fallback_location: root_path)
    end
    
    private

    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
end


