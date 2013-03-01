require 'spec_helper'

describe TasksController do

  let(:task)    { mock_model(Task) }

  context 'with authorized user' do
    login_user

    describe 'GET index' do   
      before :each do
        @tasks = (0...3).map { build :task }
        Task.should_receive(:search).and_return(@tasks)
      end

      it 'assigns @tasks' do 
        get :index
        assigns[:tasks].should be_eql(@tasks)
      end

      it 'renders the index template' do
        get :index
        response.should render_template('index')
      end
    end

    describe 'GET new' do
      before :each do
        Task.should_receive(:new).and_return(task)
        task.should_receive(:owner=).with(controller.current_user)
        task.should_receive(:owner=).with(controller.current_user)
      end

      it 'assigns @task' do
        get :new
        assigns[:task].should be_eql(task)
      end

      it 'renders the new template' do
        get :new
        response.should render_template('new')
      end
    end

    describe 'GET edit' do
      context 'with requested task exists' do
        before :each do
          Task.should_receive(:find).with(task.id.to_s).and_return(task)
          task.should_receive(:owner).and_return(controller.current_user)
        end

        it 'assigns @task' do
          get :edit, id: task.id
          assigns[:task].should be_eql(task)
        end

        it 'renders the edit template' do
          get :edit, id: task.id
          response.should render_template(action: 'edit')
        end
      end

      context 'with requested task not exists' do
        before :each do
          Task.should_receive(:find).with(task.id.to_s).and_raise(ActiveRecord::RecordNotFound)
        end 

        it { expect{ get :edit, id: task.id }.to raise_error(ActionController::RoutingError) }
      end
    end

    describe 'POST create' do
      let(:params)  { { title: 'title', problem: 'problem', solution: 'solution' }.stringify_keys }

      context 'with requested task exists' do
        before :each do
          Task.stub(:new).with(params).and_return(task)
          task.stub(:owner=).with(controller.current_user).and_return(controller.current_user)
          task.stub(:save).and_return(true)
        end

        it 'assigns @task' do
          post :create, task: params
          assigns[:task].should be_eql(task)
        end

        context 'with valid params' do
          it 'saves the task' do
            task.should_receive(:save).and_return(true)
            post :create, task: params
          end

          it 'redirects to the Task index' do
            post :create, task: params
            response.should redirect_to(action: 'show', id: task.id)
          end
        end 

        context 'with invalid params' do
          before { task.should_receive(:save).and_return(false) }

          it 're-renders the new template' do
            post :create, task: params
            response.should render_template(action: 'new')
          end
        end
      end
    end

    describe 'PUT update' do
      let(:params)  { { title: 'update_title', problem: 'update_problem', solution: 'update_solution' }.stringify_keys }

      context 'with requested task exists' do
        before :each do
          Task.should_receive(:find).with(task.id.to_s).and_return(task)
          task.should_receive(:owner).and_return(controller.current_user)
          # task.stub(:update_attributes).and_return(true)
        end

        it 'assigns @task' do
          put :update, id: task.id, task: params
          assigns[:task].should be_eql(task)
        end

        context 'with valid params' do
          # it 'updates the requested task' do
          #   task.should_receive(:update_attributes).and_return(true)
          #   put :update, id: task.id, task: params
          # end

          # it 'redirects to the Task index' do
          #   put :update, id: task.id, task: params
          #   response.should redirect_to(action: 'show', id: task.id)
          # end
        end

        context 'with invalid params' do
          it 're-renders the edit template' do
            put :update, id: task.id, task: params
            response.should render_template(action: 'edit')
          end
        end
      end

      context 'with requested task not exists' do
        before :each do
          Task.should_receive(:find).with(task.id.to_s).and_raise(ActiveRecord::RecordNotFound)
        end 

        it { expect{ put :update, id: task.id }.to raise_error(ActionController::RoutingError) }
      end
    end

    describe 'DELETE destroy' do
      context 'with requested task exists' do
        before :each do
          Task.should_receive(:find).with(task.id.to_s).and_return(task)
          task.should_receive(:owner).and_return(controller.current_user)
          task.stub(:destroy).and_return(true)
        end

        it 'assigns @task' do
          delete :destroy, id: task.id
          assigns[:task].should be_eql(task)
        end

        context 'with valid params' do
          # it 'destroy the requested task' do
          #   task.should_receive(:destroy).and_return(true)
          #   delete :destroy, id: task.id
          # end

          # it 'redirects to the Task index' do
          #   delete :destroy, id: task.id
          #   response.should redirect_to(action: 'index')
          # end
        end
      end

      context 'with requested task not exists' do
        before :each do
          Task.should_receive(:find).with(task.id.to_s).and_raise(ActiveRecord::RecordNotFound)
        end 

        it { expect{ delete :destroy, id: task.id }.to raise_error(ActionController::RoutingError) }
      end
    end
  end

  # context 'with unauthorized user' do
  #   describe 'GET index' do      
  #     before :each do
  #       @tasks = (0...3).map { build :task }
  #       Task.should_receive(:search).and_return(@tasks)
  #     end

  #     it 'assigns @tasks' do 
  #       get :index
  #       assigns[:tasks].should be_eql(@tasks)
  #     end

  #     it 'renders the index template' do
  #       get :index
  #       response.should render_template('index')
  #     end
  #   end
 
  #   describe 'GET new' do
  #   end

  #   describe 'GET edit' do
  #   end

  #   describe 'POST create' do
  #   end

  #   describe 'PUT update' do
  #   end

  #   describe 'DELETE destroy' do
  #   end
  # end

end